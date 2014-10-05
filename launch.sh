#!/bin/bash
echo -e "\n# Starting/restarting services"
php /etc/zpanel/panel/bin/daemon.php
service apache2 restart
service mysql restart
service postfix restart
#service dovecot start
dovecot
#service cron reload
stop cron ; start cron
service bind9 start
service proftpd start
service atd start

bash
