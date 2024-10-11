all:
	mkdir -p /home/kcouchma/data/mysql /home/kcouchma/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

fclean: down
	docker system prune -fa --volumes
	sudo rm -rf /home/kcouchma/data/mysql/*
	sudo rm -rf /home/kcouchma/data/wordpress/*

re: fclean all