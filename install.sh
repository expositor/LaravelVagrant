# Get Update
sudo apt-get update

# Install Mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Install PhpMyAdmin
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'﻿

# Install Ubuntu PhP and Curl
sudo apt-get install -y vim curl python-software-properties
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update

# Install Web Packages
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-readline mysql-server-5.5 php5-mysql git-core php5-xdebug
sudo apt-get install -y phpmyadmin

# Install xdebug
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

# Mod Rewrite
sudo a2enmod rewrite

# PHP.ini Configuration
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini

# Aliases
sudo nano ~/.bash_aliases
source ~/.bashrc
# echo "alias laravelcustomize='curl -L -o install.sh https://raw.github.com/expositor/LaravelCustomize/master/install.sh && chmod +x install.sh && ./install.sh && rm install.sh'" >> /home/vagrant/.bash_aliases

# Restart Apache
sudo service apache2 restart

# Get Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install Laravel
curl -L -o laravel https://github.com/expositor/LaravelVagrant/raw/master/laravel
sudo mv laravel usr/local/bin/
sudo find /usr/local/bin/laravel -type f -exec chmod 755 {} \;
cd /vagrant
laravel new laravel

# Set Up Laravel
cd /etc/apache2/sites-available/
curl -L -o laravel.conf https://raw.github.com/expositor/LaravelVagrant/master/laravel.conf
sudo a2ensite laravel

# Reload Apache
sudo service apache2 reload