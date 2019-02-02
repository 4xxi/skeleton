#!/bin/sh

COMMAND="composer install --prefer-dist --no-progress --no-suggest --no-interaction"

if [[ "prod" = "${APP_ENV}" ]]; then
    COMMAND="${COMMAND} --no-dev  --optimize-autoloader --classmap-authoritative"
fi

if [[ ! -z "${WWW_DATA_UID}" ]]; then
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
