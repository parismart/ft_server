/* create database with the name wordpress */
CREATE DATABASE wordpress;

/*grant user 'root' access to the database */
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';

/*save changes */
FLUSH PRIVILEGES;

/* asign user */
update mysql.user set plugin = 'mysql_native_password' where user='root';
