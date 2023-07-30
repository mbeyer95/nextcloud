#!/bin/bash

# Abfrage
read -p "Bitte geben Sie ein Datenbank-Namen für Nextcloud ein: " datenbankname
read -p "Bitte geben Sie ein Datenbank-Benutzer ein: " datenbankuser
read -p "Bitte geben Sie ein Datenbank-Passwort ein: " datenbankpw
echo

# Updates installieren
echo "Updates werden installiert."
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Alle benötigten Pakete werden installiert
echo "Alle benötigten Pakete werden installiert."
sudo apt install apache2 mariadb-server libapache2-mod-php php-gd php-mysql \
php-curl php-mbstring php-intl php-gmp php-bcmath php-xml php-imagick php-zip -y

# Webmin wird installiert
echo "Webmin wird installiert."
cd ~/nextcloud
sudo apt install unzip -y
dpkg -i webmin_2.021_all.deb
sudo apt install unzip -y
apt --fix-broken install -y
dpkg -i webmin_2.021_all.deb

# PHP Mehr Arbeitsspeicher zuweisen
echo "PHP wird mehr Arbeitsspeicher zugewiesen."
sed -i "s|memory_limit = 128M|memory_limit = 1024M|" /etc/php/8.1/apache2/php.ini

cd /var/www/html
rm -rf index.html

# Nextcloud herunterladen
echo "Nextcloud wird heruntergeladen."
wget https://cloud.maximilianbeyer.de/index.php/s/6awt6TjPjMWinMA/download/latest.tar.bz2

# Nextcloud entpacken und abgelegt.
echo "Nextcloud wird entpackt und Verzeichnis wird angelegt."
tar xjf latest.tar.bz2
mv nextcloud/* .
rm -rf nextcloud
rm -rf latest.tar.bz2

# Besitzer vom Nextcloud Verzeichnis ändern
echo "Besitzer vom Nextcloud Verzeichnis ändern."
cd /var/www
sudo chown -R www-data:www-data html

# Apache neustarten
sudo systemctl restart apache2

# Datenbank erstellen
MYSQL_CMD="sudo mysql -u root -p"
SQL_CMD="CREATE DATABASE ${datenbankname}; GRANT ALL PRIVILEGES ON ${datenbankname}.* TO '${datenbankuser}'@'localhost' IDENTIFIED BY '${datenbankpw}'; FLUSH PRIVILEGES;"
echo $SQL_CMD | $MYSQL_CMD
