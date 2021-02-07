# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aduregon <aduregon@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 23:04:30 by aduregon          #+#    #+#              #
#    Updated: 2021/01/23 18:44:15 by aduregon         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	debian:buster

EXPOSE	80 443

RUN		apt-get update && apt-get install -y
RUN		apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN		apt-get -y install wget
RUN		apt-get -y install nginx
RUN		apt-get -y install mariadb-server

COPY	./srcs/nginx-conf ./tmp/nginx-conf
COPY	./srcs/phpmyadmin.inc.php ./tmp/phpmyadmin.inc.php
COPY	./srcs/wp-config.php ./tmp/wp-config.php
COPY	./srcs/autoindex.sh ./

RUN		chown -R www-data /var/www/*
RUN		chmod -R 755 /var/www/*

RUN		mkdir /var/www/localhost

RUN		mkdir /etc/nginx/ssl
RUN		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=IT"

RUN		mv ./tmp/nginx-conf /etc/nginx/sites-available
RUN		ln -s /etc/nginx/sites-available/nginx-conf /etc/nginx/sites-enabled/nginx-conf
RUN		rm -rf /etc/nginx/sites-enabled/default

RUN		mkdir /var/www/localhost/phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN		tar -xvf phpMyAdmin-5.0.4-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
RUN		mv ./tmp/phpmyadmin.inc.php /var/www/localhost/phpmyadmin/config.inc.php

RUN		cd /tmp/
RUN		wget -c https://wordpress.org/latest.tar.gz
RUN		tar -xvzf latest.tar.gz
RUN		mv wordpress/ /var/www/localhost
RUN		mv /tmp/wp-config.php /var/www/localhost/wordpress

COPY    srcs/wordpress.sql /tmp
RUN     service mysql start && mysql -u root < /tmp/wordpress.sql
    
COPY    ./srcs/start.sh ./
ENTRYPOINT bash start.sh
