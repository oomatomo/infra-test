use utf8;
use strict;
use warnings;
use Carp;
use Redis;
use DBI;

my $exit_signal = 0;

my $redis = Redis->new(server => $ENV{TEST_REDIS}.':6379');
my $dbh = DBI->connect($ENV{TEST_DB_URL}, 'infratest', 'infratest');

sub handler {
  my ($sig) = @_;
  $exit_signal = 1;
}

$SIG{'INT'}  = \&handler;
$SIG{'QUIT'} = \&handler;
$SIG{'KILL'} = \&handler;

my $key = 'click';

sub queue {
  my ($_redis, $_dbh) = @_;
  my $line = $_redis->lindex($key, 0);
  if (!defined $line) {
    return;
  }
  if ($line !~ /\d+/) {
    confess "not match number '$line'";
  }
  $_dbh->do('insert into click(media_id) values (?)', undef, $line) or confess $dbh->errstr;
  $_redis->lpop($key);
}

print "start!\n";
while (1) {
  eval {
    if (!$redis->ping) {
      print "redis ping error\n";
    }
    &queue($redis, $dbh);
  };
  if ($@) {
    print $@;
  };
  sleep 1;
  if ($exit_signal) {
    print "end!\n";
    goto end_loop;
  }
}

end_loop:
$redis->quit;
$dbh->disconnect;
