FROM mkoester/ubuntu12.04-apache2-php5
MAINTAINER Aberto Alvarez <alberto.alvarez81@gmail.com>
ENV REFRESHED_AT 2015-06-16

# apache config
RUN sed -i -e"s/^magic_quotes_gpc = Off/magic_quotes_gpc = On/" /etc/php5/apache2/php.ini
