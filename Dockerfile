
FROM alpine:3.1

RUN apk add --update wget zip


#nginx

RUN  apk add --update nginx 
RUN  mkdir /tmp/nginx
COPY nginx.conf /etc/nginx/nginx.conf


#php  

RUN apk add --update php-fpm php-pdo_mysql php-curl php-json php-xml php-zlib php-gd


# supervisord

RUN  apk add --update supervisor
COPY supervisord.ini /etc/supervisor.d/supervisord.ini


# MODX

COPY modx.sh /tmp/modx.sh
RUN  sh /tmp/modx.sh && rm /tmp/modx.sh


#mysql

RUN  apk add --update mysql mysql-client
ENV  ROOT_PWD modx
COPY mysql.sh /tmp/mysql.sh
RUN  sh /tmp/mysql.sh && rm /tmp/mysql.sh

#container configuration

EXPOSE 80
VOLUME /home/modx


#start...

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
