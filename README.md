docker-sentora
==============

A simple project to get sentora running inside a docker container.  Very premature, help welcome.

Instructions:

- Build the container, then run "./start-sentora-container.sh setup"
- Once inside the container: run "./sentora_install_ubuntu.sh" (do not press 'y' when asked to reboot)
- Leave (^P^Q) the container, commit the container
- Run with "./start-sentora-container.sh" to invoke the launch script, for production

This process is crude, and I would love to clean it up some.  Right now it is merely a proof of concept.
