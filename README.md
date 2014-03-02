Lamp alias to set up Vagrant
~~~
lamp=curl -L -o install.sh https://raw.github.com/expositor/LaravelVagrant/master/install.sh && curl -L -o Vagrantfile https://raw.github.com/expositor/LaravelVagrant/master/Vangrantfile && vagrant up
~~~

Set host redirect
~~~
edit C:\Windows\System32\drivers\etc\hosts

# Vagrant Redirect
	192.168.33.21 	app.dev
~~~

Install PhpMyAdmin
~~~
sudo apt-get install phpmyadmin
sudo nano /etc/apache2/apache2.conf
Include /etc/phpmyadmin/apache.conf
sudo /etc/init.d/apache2 restart
~~~

Laravel
~~~
composer create-project laravel/laravel --prefer-dist
~~~

