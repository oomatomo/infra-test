use utf8;
use strict;
use warnings;
use Amon2::Lite;
use JSON::XS;
use Redis;
use Carp;
use DBI;
use Log::Minimal;

my $redis = Redis->new(server => $ENV{TEST_REDIS}.':6379');
my $dbh = DBI->connect($ENV{TEST_DB_URL}, 'infratest', 'infratest');
my $key = 'click';

any '/click' => sub {
  my $c   = shift;
  my $hashcode = $c->req->param('h');
  my $res = { status => "ng" };
  if ($hashcode =~ /[a-zA-Z0-9]{8}/) {
    my $sth = $dbh->prepare("select media_id, hashcode from media where hashcode = ?");
    $sth->execute($hashcode) or confess $dbh->errstr();
    my $row = $sth->fetchrow_hashref();
    if ($row) {
      $redis->rpush($key, $row->{media_id});
      $res = { status => "ok" };
    }
  }
  return $c->create_response(
    200, [],
    [JSON::XS->new->utf8(0)->encode($res)]
  );
};

__PACKAGE__->enable_session();
__PACKAGE__->to_app();
