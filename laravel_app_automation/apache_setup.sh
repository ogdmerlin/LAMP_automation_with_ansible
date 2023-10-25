#! /bin/bash

# Inform the user about the cloning process
echo "Cloning Laravel repository..."
sudo mkdir -p /var/www/laravel
git clone https://github.com/laravel/laravel /var/www/laravel 

cd /var/www/laravel

sudo mv .env.example .env

# Install necessary dependencies for Laravel and handle errors
sudo apt-get install php-xml php-curl php-zip  zip unzip curl -y 
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/local/bin/composer

# Install and update Composer dependencies
sudo composer install 
sudo composer update 


php artisan key:generate

# Configure Apache
sudo a2dissite 000-default.conf 

# Navigate to Apache sites-available directory
cd /etc/apache2/sites-available 

# Create and configure a new .conf file for the Laravel application
sudo touch laravel.conf 
sudo tee laravel.conf <<-EOF
<VirtualHost *:80>
    ServerAdmin admin@admin.com
    ServerName laravel.local
    DocumentRoot /var/www/laravel/public

    <Directory /var/www/laravel/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/laravel-error.log
    CustomLog \${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>
EOF

# enable the site
sudo a2ensite laravel

# create the site directory
sudo mkdir -p /var/www/laravel

# copy the content to site directory
cd /home/vagrant
echo $(pwd)
sudo cp -r laravel/. /var/www/laravel/

# go back to the directory
cd /var/www/laravel
echo $(pwd)

# set permission for the files
sudo chown -R vagrant:www-data /var/www/laravel/
sudo find /var/www/laravel/ -type f -exec chmod 664 {} \;
sudo find /var/www/laravel/ -type d -exec chmod 775 {} \;
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache

# reload apache
sudo systemctl reload apache2

# done
echo 'done'