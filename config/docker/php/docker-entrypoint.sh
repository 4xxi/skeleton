#!/bin/sh

COMMAND="composer install --prefer-dist --no-progress --no-suggest --no-interaction"

if [[ "prod" = "${APP_ENV}" ]]; then
    COMMAND="${COMMAND} --no-dev  --optimize-autoloader --classmap-authoritative"
fi

if [[ ! -z "${HOST_UID}" ]]; then
    deluser www-data
    addgroup www-data
    adduser -u ${HOST_UID} -G www-data -H -s /bin/sh -D www-data

    su \
        -c "${COMMAND}" \
        -s /bin/sh \
        -m \
        www-data
else
    ${COMMAND}
    chown -R www-data var/
fi

php-fpm
