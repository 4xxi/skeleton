FROM php:7.4-fpm-alpine

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

ARG XDEBUG=yes
RUN if [ "${XDEBUG}" = "yes" ]; then apk add --no-cache --virtual .xdebug-build-deps ${PHPIZE_DEPS} \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del .xdebug-build-deps; fi;

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

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./config/docker/dev/symfony.pool.conf /usr/local/etc/php-fpm.d/