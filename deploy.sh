git fetch
git reset --hard origin/main

docker compose exec php sh -c "composer install"
docker compose exec php sh -c "php bin/console d:m:m --no-interaction"
docker compose exec php sh -c "php bin/console cache:clear"

docker run --rm -v ./:/var/www/html -w /var/www/html node:22 sh -c "yarn install && yarn build"

docker compose exec php sh -c "chown -R www-data:www-data var"
docker compose exec php sh -c "chown -R www-data:www-data public"
docker compose exec php sh -c "chown -R 1000:1000 public/index.php"

docker compose -f composer.prod.yaml up -d
