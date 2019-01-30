FROM php:7.2-fpm-alpine

COPY ./symfony.ini /usr/local/etc/php/conf.d/
COPY ./symfony.pool.conf /usr/local/etc/php-fpm.d/

RUN apk add --no-cache \
    git \
    zip \
    icu-dev \
    zlib-dev \
    postgresql-dev

RUN docker-php-ext-install \
    intl \
    opcache \
    pdo \
    pdo_pgsql \
    zip

RUN EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)" \
    && wget -q -O composer-setup.php https://getcomposer.org/installer \
    && ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"; \
    if [ "${EXPECTED_SIGNATURE}" != "${ACTUAL_SIGNATURE}" ]; then \
        >&2 echo 'ERROR: Invalid installer signature' \
        && rm composer-setup.php \
        && exit 1; \
    fi; \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer; \
    RESULT=$? \
    && rm composer-setup.php \
    && exit ${RESULT}

# Uncomment code below for enabling xDebug
# or delete it with the xdebug.ini file

#RUN apk add --no-cache --virtual .xdebug-build-deps ${PHPIZE_DEPS} \
#	&& pecl install xdebug \
#	&& docker-php-ext-enable xdebug \
#	&& apk del .xdebug-build-deps
#
#COPY xdebug.ini /usr/local/etc/php/xdebug.ini
#
#RUN cat /usr/local/etc/php/xdebug.ini >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini