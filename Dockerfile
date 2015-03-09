FROM ubuntu:14.04
MAINTAINER Joe Brown <jbrown@weeby.co>

RUN apt-get update

# Fix for mysql
RUN ln -s -f /bin/true /usr/bin/chfn

# Install our pre-reqs
RUN apt-get install -y git-core python2.7 python-pip nano man curl wget

# Download the sentora installer script
RUN wget http://sentora.org/install -O sentora_install.sh

# Patch the installer
RUN chmod +x /sentora_install.sh

ADD launch.sh launch.sh
RUN chmod +x /launch.sh

ENTRYPOINT launch.sh
