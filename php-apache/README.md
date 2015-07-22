# ubuntu12.04-apache2-php5

A Dockerfile that installs Ubuntu 12.04, apache2 and php5 with magic\_quotes\_gp enabled.

Special thanks to [mkoester](https://github.com/mkoester/docker_ubuntu12.04_apache2_php5) who did most of the hard work at all!

## Installation

Build the image yourself:

```bash
$ cd docker/images/php-apache
$ sudo docker build -t="alberto/ubuntu12.04-apache2-php5:v1" .
```

## Usage

To spawn a new instance of apache on port 80.  The -p 80:80 maps the internal docker port 80 to the outside port 80 of the host machine.

```bash
$ sudo docker run -d -p 80:80 -v <path_to_your_webapp>:/var/www/my_website/public_html alberto/ubuntu12.04-apache2-php5:v1
```

After starting the container check to see if it started and the port mapping is correct.  This will also report the port mapping between the docker container and the host machine.

```
$ sudo docker ps

0.0.0.0:80 -> 80/tcp <container name>
```

You can the visit the following URL in a browser on your host machine to get started:

```
http://127.0.0.1:80
```

## Using another container to MySQL

In order to link your Web Application to another container running MySQL, please follow the instructions in this [README](../mysql/README.md).
After starting the MySQL (named *mysql-server*) container you should run:

```bash
$ docker run -d -p 80:80 -v <path_to_your_webapp>:/var/www/my_website/public_html --link mysql-server:mysql alberto/ubuntu12.04-apache2-php5:v1
```

## Hints

How to enable [non-root](https://docs.docker.com/installation/ubuntulinux/#create-a-docker-group) use.

Remove running containers from a given pattern:
```bash
docker ps -a | grep pattern | awk '{print $1}' | xargs docker rm
```
