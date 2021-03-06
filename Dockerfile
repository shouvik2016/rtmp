FROM ubuntu:16.04
RUN apt-get update -y && apt-get install build-essential libpcre3 libpcre3-dev libssl-dev -y
EXPOSE 1935 80
ADD nginx-1.15.0 /opt/nginx-1.15.0 
ADD  nginx-rtmp-module-master /opt/nginx-rtmp-module-master 
RUN cd /opt/nginx-1.15.0 && ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master && make && make install
ADD nginx.conf /usr/local/nginx/conf/ 
ADD stat.xsl /usr/local/nginx/html/
RUN mkdir /usr/local/nginx/conf/live && mkdir /usr/local/nginx/conf/apps && cp /usr/local/nginx/sbin/nginx /usr/bin/
VOLUME /usr/local/nginx/conf/live
VOLUME /usr/local/nginx/conf/apps
CMD ["nginx", "-g", "daemon off;"]
