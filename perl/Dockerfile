FROM amazonlinux:2023
MAINTAINER oomatomo ooma0301@gmail.com

# env
ENV TZ JST-9

# install package
RUN yum update -y
RUN yum install -y gcc gcc-c++ perl make wget tar patch gzip

# Perl Env
ENV PERL_VERSION 5.14.0
ENV PATH /usr/local/perl-$PERL_VERSION/bin:$PATH
ENV PERL5LIB /usr/local/carton/lib/perl5/:$PERL5LIB

# install Perl
RUN curl -sL https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build > /usr/bin/perl-build
RUN perl -pi -e 's%^#!/usr/bin/env perl%#!/usr/bin/perl%g' /usr/bin/perl-build
RUN chmod +x /usr/bin/perl-build
RUN perl-build $PERL_VERSION /usr/local/perl-$PERL_VERSION
RUN curl -sL http://cpanmin.us/ | /usr/local/perl-$PERL_VERSION/bin/perl - --notest App::cpanminus Carton

# Mysql Client(DBD::mysqlによって依存されている)
RUN wget http://dev.mysql.com/get/Downloads/MySQL-5.5/MySQL-5.5.46-1.el6.x86_64.rpm-bundle.tar
RUN tar xvf MySQL-5.5.46-1.el6.x86_64.rpm-bundle.tar
RUN yum localinstall -y MySQL-shared-compat-5.5.46-1.el6.x86_64.rpm && \
    yum localinstall -y MySQL-shared-5.5.46-1.el6.x86_64.rpm && \
    yum localinstall -y MySQL-client-5.5.46-1.el6.x86_64.rpm && \
    yum localinstall -y MySQL-devel-5.5.46-1.el6.x86_64.rpm

WORKDIR /usr/local/src/

# Carton
COPY cpanfile cpanfile
ENV PERL_CARTON_PATH /usr/local/carton
RUN carton install --path /usr/local/carton/
