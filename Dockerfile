FROM alpine:3.1


RUN apk update && apk upgrade \

#Установка nginx, mysql, php
   && apk add nginx \ 
   
   &&  apk add mysql mysql-client \ 

   && apk add  php-fpm php-pdo_mysql php-curl php-json php-xml php-zlib php-gd 

#nginx настройка
RUN adduser -D -g 'www' www \ 

    && mkdir /www \

    && chown -R www:www /www

COPY ./nginx.conf /etc/nginx/nginx.conf

#mysql настройка
RUN /usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql \

   && chown -R mysql:mysql /var/lib/mysql

#добавление volume

VOLUME /www

#запуск сервисов
#CMD rc-service nginx restart && rc-service php-fpm start && /usr/bin/mysqld_safe & sleep 5

