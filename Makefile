.PHONY: all
all: help

DOCKER_IMAGE="hello-world:0.1.0"

up:
	@echo "Creating local cluster.."
	@kind create cluster

build:
	@echo "Building $(DOCKER_IMAGE) Docker image.."
	@docker build -t $(DOCKER_IMAGE) -f ./docker/Dockerfile .

load:
	@echo "Loaidng $(DOCKER_IMAGE) Docker image.."
	@kind load docker-image $(DOCKER_IMAGE)

down:
	@echo "Deleting local cluster.."
	@kind delete cluster

clean:
	@echo "Deleting $(DOCKER_IMAGE) Docker image.."
	@docker image rm $(DOCKER_IMAGE)

help:
	@echo "Available make targets:"
	@echo " make help         - Print help"
	@echo " make up           - Create local cluster"
	@echo " make build        - Build $(DOCKER_IMAGE) Docker image"
	@echo " make build        - Load $(DOCKER_IMAGE) Docker image"
	@echo " make down         - Delete local cluster"
	@echo " make clean        - Delete $(DOCKER_IMAGE) Docker image"
	@echo ""
