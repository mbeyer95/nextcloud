#!/bin/bash

# Updates installieren
echo "Updates werden installiert."
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# 
apt install apache2 mariadb-server libapache2-mod-php php-gd php-mysql \
php-curl php-mbstring php-intl php-gmp php-bcmath php-xml php-imagick php-zip -y

apt install unzip -y

dpkg -i webmin_2.021_all.deb

# PHP Mehr Arbeitsspeicher zuweisen
sed -i "s|memory_limit = 128M|memory_limit = 1024M|" /etc/php/8.1/apache2/phi.ini

cd /var/www/html
rm -rf index.html

