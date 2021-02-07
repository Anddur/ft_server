CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;