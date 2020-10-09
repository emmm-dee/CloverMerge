FROM php:7.2-cli-alpine

COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1

COPY composer.json composer.lock ./

RUN composer install --no-dev --no-suggest --no-interaction

COPY . ./

RUN composer dump-autoload --optimize

COPY php-custom.ini "$PHP_INI_DIR/conf.d/"

ENTRYPOINT [ "./clover-merge" ]
