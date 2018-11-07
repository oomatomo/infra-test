use mysql;
drop database if exists test;
create database if not exists infratest;
delete from mysql.user where user = '' and password = '';
update user set password = password('infratest') where user = 'root';
flush privileges;
grant super on *.* to root@'%' identified by 'infratest';
grant all on infratest.* to infratest@'%' identified by 'infratest';
