FROM php:7.3-fpm-alpine

RUN apk add --no-cache \
    git \
    icu-dev \
    libzip-dev \
    postgresql-dev \
    zip

RUN docker-php-ext-install \
    intl \
    opcache \
    pdo \
    pdo_pgsql \
    zip

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

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_MEMORY_LIMIT -1
RUN composer global require hirak/prestissimo --no-plugins --no-scripts

ARG HOST_UID

RUN if [ ! -z "${HOST_UID}" ]; then \
        deluser www-data \
        && addgroup www-data \
        && adduser -u "${HOST_UID}" -G www-data -H -s /bin/sh -D www-data; \
    fi

ENV WWW_DATA_UID ${HOST_UID}

COPY ./symfony.ini /usr/local/etc/php/conf.d/
COPY ./symfony.pool.conf /usr/local/etc/php-fpm.d/