all: build

build:
	@docker build --tag=absolootly/docker-redis .
