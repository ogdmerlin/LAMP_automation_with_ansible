#!/bin/bash

# Display the Linux distribution in use
lsb_release -a

# Update package index and handle errors
sudo apt update || { echo "Failed to update package index"; exit 1; }

# Install Apache and handle errors
sudo apt install -y apache2 || { echo "Failed to install Apache"; exit 1; }

# Enable Apache to start on boot
sudo systemctl enable apache2

# Install MySQL and handle errors
sudo apt install -y mysql-server || { echo "Failed to install MySQL"; exit 1; }

# Secure MySQL installation (Consider using a non-interactive method for automation)
echo "Securing MySQL installation..."
#sudo mysql_secure_installation

# Install PHP and required modules, then handle errors
sudo apt install -y php libapache2-mod-php php-xml php-curl || { echo "Failed to install PHP and its modules"; exit 1; }

# Restart Apache to apply changes
sudo systemctl restart apache2

# Creating a phpinfo page for testing PHP configuration
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php

echo "LAMP stack installation completed."
