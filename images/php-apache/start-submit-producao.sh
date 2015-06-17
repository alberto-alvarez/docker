#!/bin/bash

D=`basename $(pwd)`

[ "$D" == "php-apache" ] || { echo "You must run this script inside php-apache directory!"; exit 1; }

docker ps | grep submit-producao > /dev/null

if [ $? == 0 ]; then
    echo "** container already executing **"
    docker ps -l
    exit
fi

docker ps -a | grep submit-producao > /dev/null && docker start submit-producao && echo "** starting the container **"

docker ps | grep submit-producao > /dev/null

if [ $? == 0 ]; then
    docker ps -l
    exit
fi

echo "** creating a new container **"
docker run -d -P -v $(pwd)/producao:/var/www/my_website/public_html --name=submit-producao alberto/ubuntu12.04-apache2-php5:v1

docker ps -l

# set +e
# docker images | grep alberto/ubuntu12.04-apache2-php5 > /dev/null

# if [ $? != 0 ]; then
#     docker build -t alberto/ubuntu12.04-apache2-php5
# fi