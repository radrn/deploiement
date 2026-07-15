init:
	@docker compose down
	@docker compose build --no-cache --build-arg USER_ID=$$(id -u) --build-arg GROUP_ID=$$(id -g) && docker compose up -d
	@docker compose exec -T php composer install

up:
	@docker compose up -d
b:
	@docker compose exec php bash

f:
	@docker compose exec node bash

lb:
	@docker compose logs php -f

lf:
	@docker compose logs node -f

rf:
	@docker compose restart node -t 0

