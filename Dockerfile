FROM	debian:buster

ENV	AUTOINDEX=off

#Install nginx, php, mariadb, openssl, wordpress and phpMyAdmin. Remove index.
RUN	apt-get update && \
	apt-get install -y nginx \
	wget php7.3-fpm php7.3-mysql php7.3-mbstring \
	mariadb-server \
	openssl && \
	wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.tar.gz && \
	tar -xzvf phpMyAdmin-4.9.2-all-languages.tar.gz && rm -rf phpMyAdmin-4.9.2-all-languages.tar.gz && \
	mv phpMyAdmin-4.9.2-all-languages /var/www/html/phpmyadmin && \
	wget http://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && rm -rf latest.tar.gz && \
	mv wordpress /var/www/html/ && \
	rm -rf /var/www/html/index.* 

#Copy config files and import wordpress database.	
COPY	srcs/config.inc.php	/var/www/html/phpmyadmin/
COPY	srcs/wp-config.php	/var/www/html/wordpress/
COPY	srcs/index.html		/var/www/html/
COPY	srcs/nginx.cnf		/etc/nginx/sites-available/
COPY	srcs/init.sql		/tmp/
COPY	srcs/wordpress.sql	/tmp/

#Remove default files and create link. Change permissions. Start mysql and create database wordpress. Create key and certificate SSL. Run services.
RUN	rm -rf /etc/nginx/sites-available/default && \
	rm -rf /etc/nginx/sites-enabled/default && \
	ln -sf /etc/nginx/sites-available/nginx.cnf /etc/nginx/sites-enabled/ && \
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
ENTRYPOINT	if [ ${AUTOINDEX} = "on" ] ; then sed -i '23 s/autoindex off;/autoindex on;/g' /etc/nginx/sites-available/nginx.cnf; fi && \
		service nginx start && service php7.3-fpm start && service mysql start && bash
