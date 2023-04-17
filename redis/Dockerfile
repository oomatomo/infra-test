FROM amazonlinux:2023
MAINTAINER oomatomo ooma0301@gmail.com

# install package
RUN yum update -y
RUN yum install -y wget tar make gcc gzip

RUN cd /tmp && \
      wget http://download.redis.io/releases/redis-2.8.21.tar.gz && \
      tar xvzf redis-2.8.21.tar.gz && \
      cd redis-2.8.21 && \
      make && \
      make install && \
      cp -f src/redis-sentinel /usr/local/bin && \
      mkdir -p /etc/redis && \
      cp -f *.conf /etc/redis

# change bind
RUN sed -e "s/# bind 127.0.0.1/bind 0.0.0.0/" -i /etc/redis/redis.conf
RUN sed -e "s/# unixsocket \/tmp\/redis.sock/unixsocket \/var\/tmp\/redis.sock/" -i /etc/redis/redis.conf

EXPOSE 6379
CMD ["redis-server", "/etc/redis/redis.conf"]
