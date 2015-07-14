#!/bin/bash

set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" == "setup" ]; then
  ENTRYPOINT='--entrypoint="/sentora_install.sh"'
  IMAGE_VERSION="setup"
  OPTS="it"

  echo "Getting sentora version"
  VER=`curl -L http://sentora.org/install 2>/dev/null | perl -ln -e'/SENTORA_INSTALLER_VERSION="(.*?)"/ && print $1'`
else
  ENTRYPOINT='--entrypoint="/launch.sh"'
  IMAGE_VERSION="latest"
  OPTS="dit"
fi

# Check if we want to load in data from a backup volume
if [ -e "$1" ]; then
  VOLUMES=`$DIR/backup.py -g $1`
  echo "Running with attached volumes: $VOLUMES"
  echo
else
  VOLUMES=""
fi

# Run the docker instance!
docker run -$OPTS $ENTRYPOINT \
  -p 20:20 -p 21:21 -p 25:25 -p 53:53 -p 8080:80 -p 110:110 -p 143:143 -p 443:443 -p 3306:3306 -p 993:993 -p 587:587 \
  $VOLUMES \
  sentora:$IMAGE_VERSION

# Finish setup
if [ "$1" == "setup" ]; then
  SETUP_CONTAINER=`docker ps -a | grep -m 1 "sentora:$IMAGE_VERSION" | awk '{print $1;}'`

  echo "Tagging $SETUP_CONTAINER as latest"
  docker commit $SETUP_CONTAINER sentora:latest

  echo "Tagging $SETUP_CONTAINER as $VER"
  docker commit $SETUP_CONTAINER sentora:$VER

  echo "Setup complete"
fi
