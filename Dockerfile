FROM ubuntu:trusty

ENV PHP_VERSION=5.6
ENV PHPUNIT_VERSION=5

RUN apt-get update \
    && apt-get install -y software-properties-common wget \ 
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update  \
    && apt-get install -y php${PHP_VERSION} php${PHP_VERSION}-xml php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-json \
        php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-mysqlnd \
        php${PHP_VERSION}-imap php${PHP_VERSION}-mcrypt php${PHP_VERSION}-zip \
        php${PHP_VERSION}-intl php${PHP_VERSION}-dev php${PHP_VERSION}-bcmath \        
        pkg-config php-pear libcurl4-openssl-dev libssl-dev libsslcommon2-dev php-xdebug \
        php{PHP_VERSION}-mongodb \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && wget -O phpunit https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar && chmod +x phpunit && mv phpunit /usr/local/bin/phpunit

ADD config.php /etc/config_pw2/config.php
ADD auth.rsa.pub /etc/config_pw2/auth.rsa.pub
ADD auth.rsa /etc/config_pw2/auth.rsa