#!/bin/bash
echo -e "\n# Starting/restarting services"

DEFAULT_CONF="/etc/apache2/sites-enabled/000-default.conf"

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
