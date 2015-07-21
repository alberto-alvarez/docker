#!/bin/bash
#
# Scripts that starts a container based on the seed name parameter given. In fact it uses
# the given name in all code to automatically mount the volume, for example.
#
# Version: 1.1

if [ $# -ne "1" ]
then
  echo "Usage: `basename $0` project-name"
  exit 1;
fi

# It's expected that all websites are inside config directory below (enter full path)
BASE_APP_DIR="/full/path/project"

docker ps | grep $1 > /dev/null
if [ $? == 0 ]; then
    echo "** Nothing to do: the container was already running **"
    docker ps
    exit
fi

docker ps -a | grep $1 > /dev/null && docker start $1 && echo "** Starting the container $1**"

docker ps | grep $1 > /dev/null
if [ $? == 0 ]; then
    docker ps
    exit
fi

echo "** Creating a new container $1 **"
NAME=$(echo $1 | sed -s 's/_/\//')
docker run -d -P -v $BASE_APP_DIR/$NAME:/var/www/my_website/public_html --name=$1 alberto/ubuntu12.04-apache2-php5:v1
docker ps

# set +e
# docker images | grep alberto/ubuntu12.04-apache2-php5 > /dev/null

# if [ $? != 0 ]; then
#     docker build -t alberto/ubuntu12.04-apache2-php5
# fi
