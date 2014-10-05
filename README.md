docker-sentora
==============

A simple project to get sentora running inside a docker container.  Very premature, help welcome.

Instructions:

- Run "./build-sentora-container.sh"
- Run "./start-sentora-container.sh setup"
- Once inside the container, follow instructions, and do not press 'y' when asked to reboot
- NOTE: The script will automatically tag the image for you
- Run with "./start-sentora-container.sh" to invoke the launch script for production

This process is crude, and I would love to clean it up some.  Right now it is merely a proof of concept.
