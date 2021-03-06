#Hosts Redirect

<b>Edit hosts redirect</b><br>
C:\Windows\System32\drivers\etc\hosts
~~~
# Vagrant Redirect
	192.168.33.21 	trendfolio.com
~~~

#Set up Pre-packaged Box

<b>Add local box </b>
~~~
vagrant box add --name Ubuntu64 C:\Users\Daniel\Apps\<name of box>.box
vagrant init <name of box>
~~~

<b>Edit Vagrantfile</b>
~~~
25
26 config.vm.network "private_network", ip: "192.168.33.21"
27
~~~

Normal Mount (all platforms)
~~~
40
41 config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=0777", "fmode=666"]
42
~~~

Rsync (all platforms)
~~~
40
41 config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=0777", "fmode=666"], type: "rsync",
42    rsync__exclude: ".git/"
~~~

NFS (Linux and OSX only)
~~~
40
41 config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=0777", "fmode=666"]}
42
~~~

<b>Start Vagrant</b>

If Rsync
~~~
vagrant up
vagrant rsync-auto
~~~

If Normal or NFS
~~~
vagrant up
~~~

#Set up Repository Box
    
<b>Command to set up Vagrant</b>
~~~
curl -L -o install.sh https://raw.github.com/expositor/VagrantFiles/master/trendfolio/install.sh && curl -L -o Vagrantfile https://raw.github.com/expositor/LaravelVagrant/master/trendfolio/Vangrantfile && vagrant up
~~~

Shortened URL
~~~
curl -L -o install.sh http://goo.gl/TXlrhc && curl -L -o Vagrantfile http://goo.gl/rgI1Fx && vagrant up
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
