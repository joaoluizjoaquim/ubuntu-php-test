FROM ubuntu:trusty

ENV PHP_VERSION=5.6
ENV PHPUNIT_VERSION=5

RUN apt-get update \
    && apt-get install -y software-properties-common wget curl \ 
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/apache2
RUN apt-get update \
    && apt-get install -y \
        php${PHP_VERSION} php${PHP_VERSION}-xml php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-json \
        php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-mysqlnd \
        php${PHP_VERSION}-imap php${PHP_VERSION}-mcrypt php${PHP_VERSION}-zip \
        php${PHP_VERSION}-intl php${PHP_VERSION}-dev php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-gettext php${PHP_VERSION}-cgi php${PHP_VERSION}-cgi \
        php${PHP_VERSION}-gd libapache2-mod-php${PHP_VERSION} php${PHP_VERSION}-xdebug \
        php-pear libcurl3-openssl-dev \
        pkg-config libssl-dev libsslcommon2-dev openssl \
        make paxctl gnupg patch apache2 \
    && pecl install mongodb \
    && echo "extension=mongodb.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` \
    && echo "extension=mongodb.so" >> /etc/php/${PHP_VERSION}/fpm/php.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && wget -O phpunit https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar && chmod +x phpunit && mv phpunit /usr/local/bin/phpunit

ADD config.php /etc/config_pw2/config.php
ADD auth.rsa.pub /etc/config_pw2/auth.rsa.pub
ADD auth.rsa /etc/config_pw2/auth.rsa