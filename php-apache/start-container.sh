#!/bin/bash
#
# Scripts that starts a container based on the seed name parameter given. In fact it uses
# the given name in all code to automatically mount the volume, for example.
#
# Version: 1.3
#

function show_help {
    echo "Usage: `basename $0` [-c] [-h|-?] project_client"
    echo "Usage: `basename $0` [-c] [-h|-?] project"
    echo "Usage: `basename $0` [-c] [-h|-?]"
    echo "Arguments:"
    echo "  -c => create all containers instead of just starting"
    echo "  -h => show this help"
    echo "  -? => show this help"
    exit 1
}

function ps_exit {
    [ "$1" ] && echo "$1"
    echo
    docker ps
    exit 0
}

# This script expects the CONSTANTS below to be defined.
# It is best if you define then in a super secret ~/.localrc file like this:
source ~/.localrc

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
create_container=0
verbose=0
while getopts "h?vc" opt; do
    case "$opt" in
    h|\?)
        show_help
        ;;
    v)  verbose=1
        ;;
    c)  create_container=1
        ;;
    esac
done
shift $((OPTIND-1))

[ "$1" = "--" ] && shift

# It's expected that all websites are inside config directory below (enter full path)
BASE_APP_DIR="$HOME/projects"

# MySQL container name
MYSQL="mysql-server"

# MySQL data directory
MYSQL_DATA="/home/alberto/mysqldata"

# MYSQLPASS="MysqlPassword"

if [ $# -gt "1" ]; then
    show_help
fi

if [ $# -eq 0 ]; then
    set -- "projects"
    BASE_APP_DIR="$HOME"
fi


if [ "$1" != "$MYSQL" ]; then
    if [[ $create_container -eq 1 ]]; then
        $0 -c $MYSQL
    else
        $0 $MYSQL
    fi
fi

if [ "$1" == "$MYSQL" ]; then
    if [[ $create_container -eq 1 ]]; then
        docker ps | grep $1 > /dev/null && echo "** Stopping the container $1 **" && docker stop $1
        docker ps -a | grep $1 > /dev/null && echo "** Removing the container $1 **" && docker rm $1
    else
        docker ps | grep $1 > /dev/null && echo "** Container MySQL 5.5 is already running **" && exit
        docker ps -a  | grep $1 > /dev/null && echo "** Starting MySQL 5.5 container $1 **" && docker start $1 && exit
    fi

    echo "** Creating a new MySQL 5.5 container $1 **"
    mkdir -p $MYSQL_DATA
    docker run -d -e MYSQL_ROOT_PASSWORD=$MYSQLPASS -v $MYSQL_DATA:/var/lib/mysql --name=$1 mysql:5.5
    ps_exit
fi

if [[ $create_container -eq 1 ]]; then    
    docker ps | grep $1 > /dev/null && echo "** Stopping the container $1 **" && docker stop $1
    docker ps -a | grep $1 > /dev/null && echo "** Removing the container $1 **" && docker rm $1
else
    docker ps | grep $1 > /dev/null && ps_exit "** Container $1 is already running **"
    docker ps -a  | grep $1 > /dev/null && echo "** Starting the container $1 **" && docker start $1 && ps_exit
fi

echo "** Creating a new container $1 **"
NAME=$(echo $1 | sed -s 's/_/\//')
docker run -d -P -v $BASE_APP_DIR/$NAME:/var/www/my_website/public_html --name=$1 --link mysql-server:mysql alberto/ubuntu12.04-apache2-php5:v1
ps_exit

# set +e
# docker images | grep alberto/ubuntu12.04-apache2-php5 > /dev/null

# if [ $? != 0 ]; then
#     docker build -t alberto/ubuntu12.04-apache2-php5
# fi
