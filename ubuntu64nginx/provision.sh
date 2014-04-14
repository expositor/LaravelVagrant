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

# PHP
sudo apt-get install -y php5-cli php5-dev php-pear php5-mysql php5-pgsql php5-sqlite php-apc php5-json php5-curl php5-dev php5-gd php5-gmp php5-mcrypt php5-xdebug php5-memcached php5-readline

# Install xdebug
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

# Make MCrypt Available
sudo ln -s /etc/php5/conf.d/mcrypt.ini /etc/php5/mods-available
sudo php5enmod mcrypt

# NGINX & PHP-FPM
sudo apt-get install -y nginx php5-fpm
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default
sudo service nginx restart

# Install Mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get install -y mysql-server

# Configure php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 64M /" /etc/php5/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/cli/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 128M /" /etc/php5/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php5/cli/php.ini

sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 64M /" /etc/php5/fpm/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/fpm/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 128M /" /etc/php5/fpm/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php5/fpm/php.ini

# Configure NGINX and PHP-FPM User
sudo sed -i "s/user www-data;/user vagrant;/" /etc/nginx/nginx.conf
sudo sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

sudo sed -i "s/user = www-data/user = vagrant/" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/group = www-data/group = vagrant/" /etc/php5/fpm/pool.d/www.conf

# Install Mailparse PECL Extension
sudo pecl install mailparse
echo "extension=mailparse.so" > sudo /etc/php5/mods-available/mailparse.ini
sudo ln -s /etc/php5/mods-available/mailparse.ini /etc/php5/cli/conf.d/20-mailparse.ini
sudo ln -s /etc/php5/mods-available/mailparse.ini /etc/php5/fpm/conf.d/20-mailparse.ini

# Restart Service
sudo service nginx restart
sudo service php5-fpm restart

# Add Vagrant User to WWW-Data
sudo usermod -a -G www-data vagrant
sudo id vagrant
sudo groups vagrant

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install Laravel
composer create-project laravel/laravel /var/www/laravel/

# Install Node.JS, Grunt, Gulp
sudo apt-get install -y nodejs
sudo npm install -g grunt-cli
sudo npm install -g gulp

# Install Redis-Server, Postgres, and Memcached
sudo apt-get install -y postgresql redis-server memcached
