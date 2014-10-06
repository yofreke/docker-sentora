docker-sentora
==============

A simple project to get sentora running inside a docker container.  Very premature, help welcome.

First Run Instructions:

- Run "./build-sentora-container.sh"
- Run "./start-sentora-container.sh setup"
- Once inside the container, follow instructions, and do not press 'y' when asked to reboot
- NOTE: The script will automatically tag the image for you
- Run with "./start-sentora-container.sh" to invoke the launch script for production

Backup Instructions:

- Run "./backup.py -t <container id>" to determine if there are any important files on your server that will not be included in the backup
- NOTE: If there are missed files, add the appropriate folders to the array in backup.py
- Run "./backup.py -b <container id> <path on host>" to backup all important files into the <path on host> directory
- Now to start a new sontara instance using a backup directory, run "./start-sentora-container.sh <path on host>"

This process is crude, and I would love to clean it up some.  Right now it is merely a proof of concept.
