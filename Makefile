all: build

build:
	@docker build --tag=sameersbn/redis .
