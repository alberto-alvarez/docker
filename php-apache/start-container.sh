#!/bin/bash
#
# Scripts that starts a container based on the seed name parameter given. In fact it uses
# the given name in all code to automatically mount the volume, for example.
#
# Version: 1.2

# It's expected that all websites are inside config directory below (enter full path)
BASE_APP_DIR="/home/alberto/projects"

# MySQL container name
MYSQL="mysql-server"

# MySQL data directory
MYSQL_DATA="/home/alberto/mysqldata"

if [ $# -ne "1" ]
then
  echo "Usage: `basename $0` project-name"
  exit 1;
fi

if [ "$1" != "$MYSQL" ]; then
    ./$0 $MYSQL
fi

docker ps    | grep $1 > /dev/null && docker stop $1 && echo "** Stopping the container $1 **"
docker ps -a | grep $1 > /dev/null && docker rm $1 && echo "** Removing the container $1 **"

if [ "$1" == "$MYSQL" ]; then
    echo "** Creating a new MySQL 5.5 container $1 **"
    mkdir -p $MYSQL_DATA
    docker run -d -e MYSQL_ROOT_PASSWORD=alervfmm0420 -v $MYSQL_DATA:/var/lib/mysql --name=$1 mysql:5.5
    exit 0
fi

echo "** Creating a new container $1 **"
NAME=$(echo $1 | sed -s 's/_/\//')
docker run -d -P -v $BASE_APP_DIR/$NAME:/var/www/my_website/public_html --name=$1 --link mysql-server:mysql alberto/ubuntu12.04-apache2-php5:v1
docker ps

# set +e
# docker images | grep alberto/ubuntu12.04-apache2-php5 > /dev/null

# if [ $? != 0 ]; then
#     docker build -t alberto/ubuntu12.04-apache2-php5
# fi
