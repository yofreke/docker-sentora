#!/bin/bash
echo -e "\n# Starting/restarting services"

DEFAULT_CONF="/etc/apache2/sites-enabled/000-default.conf"
#if [ -e "$DEFAULT_CONF" ]; then
  # Remove the default configuration file
#  rm $DEFAULT_CONF
  # Link in the real one..? Why is this not done correctly in the first place?
#  ln -s /etc/zpanel/configs/apache/httpd-vhosts.conf /etc/apache2/sites-enabled/
#fi

# Start all the services
service apache2 restart
service mysql restart
service postfix restart
dovecot
cron
service bind9 start
service proftpd start
service atd start
php /etc/zpanel/panel/bin/daemon.php

# Start a bash instance for us to attach to if we desire
bash
