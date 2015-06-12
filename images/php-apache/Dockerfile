FROM php:5.3-apache
MAINTAINER Aberto Alvarez <alberto.alvarez81@gmail.com>

#RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y libapache2-mod-php5

COPY config/php.ini /usr/local/lib/php.ini
COPY config/php.ini /etc/php5/apache2/php.ini