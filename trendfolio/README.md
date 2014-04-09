<b>Lamp command to set up Vagrant</b>
~~~
curl -L -o install.sh https://raw.github.com/expositor/VagrantFiles/master/trendfolio/install.sh && curl -L -o Vagrantfile https://raw.github.com/expositor/LaravelVagrant/master/trendfolio/Vangrantfile && vagrant up
~~~

Shortened URL

~~~
curl -L -o install.sh http://goo.gl/TXlrhc && curl -L -o Vagrantfile http://goo.gl/rgI1Fx && vagrant up && vagrant rsync && vagrant rsync-auto
~~~

curl -L -o install2.sh http://goo.gl/QNVaym && curl -L -o Vagrantfile http://goo.gl/rgI1Fx && vagrant up



<b>Set host redirect</b><br>
edit C:\Windows\System32\drivers\etc\hosts
~~~
# Vagrant Redirect
	192.168.33.21 	trendfolio.com
~~~

Install PhpMyAdmin
~~~
sudo apt-get install phpmyadmin
sudo nano /etc/apache2/apache2.conf
Include /etc/phpmyadmin/apache.conf
sudo /etc/init.d/apache2 restart
~~~


Keygen for Git
~~~
ssh-keygen -t rsa -C "lee4runner@hotmail.com"
cp id_rsa.pub /vagrant
ssh -T git@github.com
~~~
<b>Install PHP</b>

In Control Panel window, choose Programs.<br>
In Programs and Features, choose Turn Windows features on or off.<br>
Check Internet Information Service and click OK button.<br>
Download Web Platform Installer from http://www.microsoft.com/web/downloads/platform.aspx <br>
Run wpilauncher.exe<br>
In Web Platform Installer window, choose Products tab and search PHP version that we will install.<br>
Click Add button.<br>
Click Install button.


<b>Install Composer</b>

https://getcomposer.org/download/ <br>
Download the Windows Installer


<b>Install Laravel</b>

http://laravel.com/laravel.phar<br>
Move the laravel.phar folder to C:\ProgramData\ComposerSetup\bin

Create a file called laravel.bat put:
~~~
@ECHO OFF
php "%~dp0laravel.phar" %*
~~~

Create a file called laravel put:
~~~
dir=$(d=$(dirname "$0"); cd "$d" && pwd)

if command -v 'cygpath' >/dev/null 2>&1; then

	if [[ $(which php) == /cygdrive/* ]]; then
  		dir=$(cygpath -m $dir);
  	fi
fi

dir=$(echo $dir | sed 's/ /\ /g')
php "${dir}/laravel.phar" $*
~~~
Goto project directory and type:
~~~
laraval new laravel
~~~
