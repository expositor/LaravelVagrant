# Install Updates
sudo apt-get update
sudo apt-get upgrade -y

# Install Basic Packages
sudo apt-get install -y unzip vim git-core curl wget build-essential python-software-properties software-properties-common gcc libmcrypt4 libpcre3-dev make python2.7-dev python-pip supervisor whois

# Helpful Python Packages
sudo pip install httpie
sudo pip install fabric

# Repositories
sudo add-apt-repository -y ppa:nijel/phpmyadmin
sudo add-apt-repository -y ppa:nginx/stable
sudo apt-add-repository -y ppa:chris-lea/node.js
sudo apt-get update

# Set Timezone (Los Angeles)
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# PHP
sudo apt-get install -y php5-cli php5-dev php-pear php5-mysql php5-pgsql php5-sqlite php-apc php5-json php5-curl php5-dev php5-gd php5-gmp php5-mcrypt php5-xdebug php5-memcached php5-readline

# Configure xdebug
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

# Configure OPcache (http://halfelf.org/2013/trading-apc-for-zend/)
#cat << EOF | sudo tee -a /etc/php5/mods-available/opcache.ini
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.enable_cli=1
#EOF

# Make MCrypt Available
sudo ln -s /etc/php5/conf.d/mcrypt.ini /etc/php5/mods-available
sudo php5enmod mcrypt

# Install NGINX & PHP-FPM
sudo apt-get install -y nginx php5-fpm

# Install Mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server

# Install PhpMyAdmin
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect false'﻿
sudo apt-get install -y phpmyadmin

# Configure php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 64M /" /etc/php5/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/cli/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 128M /" /etc/php5/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php5/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php5/cli/php.ini

sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 64M /" /etc/php5/fpm/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/fpm/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 128M /" /etc/php5/fpm/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php5/fpm/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php5/fpm/php.ini

# Configure NGINX
sudo sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

# Restart Service
sudo service nginx restart
sudo service php5-fpm restart

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# (Optional) Install NFS Support 
# (On Local Machine) sudo apt-get install -y nfs-kernel-server nfs-common portmap
# (On Vagrant Machine) sudo apt-get install nfs-common portmap

# Add a Website
# sudo rm /etc/nginx/sites-enabled/default
# sudo rm /etc/nginx/sites-available/default
# cd /etc/nginx/sites-available/
# sudo curl -L -o trendfolio https://raw.github.com/expositor/VagrantFiles/master/ubuntu64nginx/laravel
# sudo curl -L -o trendfolio https://raw.github.com/expositor/VagrantFiles/master/ubuntu64nginx/trendfolio
# ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/laravel
# ln -s /etc/nginx/sites-available/trendfolio /etc/nginx/sites-enabled/trendfolio
# sudo service nginx restart

# (Optional) Install Mailparse PECL Extension
# sudo pecl install mailparse
# echo "extension=mailparse.so" > sudo /etc/php5/mods-available/mailparse.ini
# sudo ln -s /etc/php5/mods-available/mailparse.ini /etc/php5/cli/conf.d/20-mailparse.ini
# sudo ln -s /etc/php5/mods-available/mailparse.ini /etc/php5/fpm/conf.d/20-mailparse.ini

# (Optional) Add "vagrant" User to WWW-Data
# sudo usermod -a -G www-data vagrant
# sudo id vagrant
# sudo groups vagrant

# (Optional) Configure NGINX and FPM for "vagrant" user
# sudo sed -i "s/user www-data;/user vagrant;/" /etc/nginx/nginx.conf
# sudo sed -i "s/user = www-data/user = vagrant/" /etc/php5/fpm/pool.d/www.conf
# sudo sed -i "s/group = www-data/group = vagrant/" /etc/php5/fpm/pool.d/www.conf 
# sudo service nginx restart
# sudo service php5-fpm restart

# (Optional) Install Laravel
# composer create-project laravel/laravel /usr/share/nginx/www/laravel/
# sudo ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/laravel

# (Optional) Node.JS, Grunt, Gulp
# sudo apt-get install -y nodejs
# sudo npm install -g grunt-cli
# sudo npm install -g gulp

# (Optional) Install Redis-Server, Postgres, and Memcached
# sudo apt-get install -y postgresql redis-server memcached

# (Optional) Post Install Commands

# APC (/apc.php)
# cp /usr/share/doc/php-apc/apc.php /usr/share/nginx/www/<domain name>/<public>

# (OPCache)
# cd /usr/share/nginx/www/<domain name>/<public>
# wget https://raw.github.com/rlerdorf/opcache-status/master/opcache.php
