FROM	debian:buster

MAINTAINER	Paris Martinez Ruiz <parmarti@student.42madrid.com>

ENV	AUTOINDEX=off

#Install nginx, php, mariadb and openssl. Remove index.
RUN	apt-get update && \
	apt-get install -y nginx \
	php7.3-fpm php7.3-mysql php7.3-mbstring \
	mariadb-server \
	openssl \
	vim && \
	rm -rf /var/www/html/index.*

#Install wordpress and phpMyAdmin. Copy config files.	
COPY	srcs/wordpress		/var/www/html/wordpress
COPY	srcs/phpMyAdmin		/var/www/html/phpMyAdmin
COPY	srcs/config.inc.php	/var/www/html/phpMyAdmin/
COPY	srcs/wp-config.php	/var/www/html/wordpress/
COPY	srcs/index.html		/var/www/html/
COPY	srcs/config-nginx	/etc/nginx/sites-available/
COPY	srcs/init.sql		/tmp/
COPY	srcs/wordpress.sql	/tmp/

#Remove default files and create link. Change permissions. Start mysql and create database wordpress. Create key and certificate SSL. Run services.
RUN	rm -rf /etc/nginx/sites-available/default && \
	rm -rf /etc/nginx/sites-enabled/default && \
	ln -sf /etc/nginx/sites-available/config-nginx /etc/nginx/sites-enabled/ && \
	chown -R www-data:www-data /var/www/* && \
	chmod -R 755 /var/www/* && \
	chmod 700 /etc/ssl/private && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
	-keyout /etc/ssl/private/parmarti.key \
	-out /etc/ssl/certs/parmarti.crt && \
	openssl dhparam -out /etc/nginx/dhparam.pem 1000 && \
	service mysql start && \
	mysql -u root --password= < tmp/init.sql && \
	mysql wordpress -u root --password= < tmp/wordpress.sql

#Set autoindex and restart.
ENTRYPOINT	if [ ${AUTOINDEX} = "on" ] ; then sed -i '35 s/autoindex off;/autoindex on;/g' /etc/nginx/sites-available/config-nginx; fi && \
		service nginx start && service php7.3-fpm start && service mysql start && bash
