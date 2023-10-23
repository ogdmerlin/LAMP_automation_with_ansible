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

sudo php artisan key:generate

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

# Set permissions for the Laravel application
sudo chown -R www-data:www-data /var/www/laravel
sudo chmod -R 755 /var/www/laravel/storage

# Enable the Laravel site and restart Apache to apply changes
sudo a2ensite laravel.conf 
sudo systemctl restart apache2 

echo "Apache2 and Laravel setup completed."
