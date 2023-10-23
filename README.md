# # **LAMP Stack Deployment: Automation with Vagrant and Ansible**

**Overview**

Welcome to a sophisticated automation project that aims to proficiently set up a LAMP (Linux, Apache, MySQL, PHP) stack on a pair of Ubuntu servers denominated as "Master" and "Slave." Leveraging the powerful capabilities of Vagrant and Ansible, this project encapsulates the essence of modern DevOps practices, ensuring a streamlined, reliable, and replicable environment for hosting a PHP application.

#

# # **Objective:** 👇🏽

`Provisioning Virtual Servers`: Automatically instantiate two robust Ubuntu-based servers.

`LAMP Stack Deployment`: Curate a bash script to facilitate the impeccable deployment of a LAMP stack on the Master node.

`Application Deployment`: Clone a PHP Laravel application from a designated GitHub repository, ensuring it is meticulously configured and primed for execution.

`Ansible Automation`: Harness the automation prowess of Ansible to manage the deployment intricacies on the Slave node, driving operational excellence and configuration uniformity.

#

# # **Prerequisites:** 👇🏽

**Before diving into the deployment odyssey, ensure the availability of the following tools:**

`Vagrant`

`VirtualBox`

`Ansible`

`Git`

#

# # **Repository Structure:** 👇🏽

The repository is a trove of scripts and configuration files, each playing a pivotal role in orchestrating the automation symphony:

`Vagrantfile`: Orchestrates the provisioning of the virtual environments, laying the foundation upon which the LAMP stack will flourish.

`lampstack_install.sh`: A bash maestro that conducts the LAMP stack installation with precision, ensuring each component is perfectly tuned.

`apache_setup.sh`: The virtuoso script that fine-tunes the Apache configuration, ensuring it performs in harmony with the application requirements.

#

# # **Getting Started:** 👇🏽

`Clone the repository to your local machine.`

    git clone https://https://github.com/ogdmerlin/LAMP_automation_with_ansible

`Initiate Vagrant:`

    vagrant up

`Deploy the LAMP Stack:`

        vagrant ssh master
        cd /vagrant
        bash lampstack_install.sh

`verify the stacks are well installed and configured:`
<img src=Assets/php-m.png>
<img src=Assets/php-v.png>

`Deploy the Application:`

            vagrant ssh master
            cd /vagrant
            bash apache_setup.sh

<img src=Assets/apache2_running.png>
<img src=Assets/mysql-status.png>

`Access the Application:`

                http:// your master node IP address

<img src=Assets/deployed_img.png>

#

PHP Laravel Application

Repository: [Laravel Application](https://https://github.com/laravel/laravel)
Contributions

Contributions are the lifeblood of this project’s continual evolution and refinement. Feel free to compose your own melodies of improvement and enhancement, submitting them through Pull Requests.

#

Author

OGDMERLIN ..✍🏼
