FROM amazonlinux:2023
MAINTAINER oomatomo ooma0301@gmail.com

# env
ENV TZ=JST-9
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# install package
RUN yum update -y
RUN yum install -y gcc gcc-c++ make ncurses-devel vim perl zlib-devel pcre-devel zip unzip perl-ExtUtils-Embed openldap-devel git vsftpd httpd cpan libxml2-devel expat-devel libcurl-devel sharutils tmux openssl-devel libuuid-devel uuid uuid-devel uuidd m4 sendmail sendmail-cf
RUN yum install -y wget tar

# install mysql
RUN wget http://dev.mysql.com/get/Downloads/MySQL-5.5/MySQL-5.5.46-1.el6.x86_64.rpm-bundle.tar
RUN tar xvf MySQL-5.5.46-1.el6.x86_64.rpm-bundle.tar
RUN yum localinstall -y MySQL-shared-compat-5.5.46-1.el6.x86_64.rpm
RUN yum localinstall -y MySQL-shared-5.5.46-1.el6.x86_64.rpm
RUN yum localinstall -y MySQL-server-5.5.46-1.el6.x86_64.rpm
RUN yum localinstall -y MySQL-client-5.5.46-1.el6.x86_64.rpm
RUN yum localinstall -y MySQL-devel-5.5.46-1.el6.x86_64.rpm

# add mysql
COPY privilege.development.sql /tmp/
COPY infratest.sql /tmp/

# my.cnf
COPY my.development.cnf /etc/my.cnf
# mysql start
RUN /etc/init.d/mysql start \
   && mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql \
   && mysql -u root < /tmp/privilege.development.sql \
   && mysql -u root -pinfratest -D infratest < /tmp/infratest.sql

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
