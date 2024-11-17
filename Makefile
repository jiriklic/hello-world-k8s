.PHONY: all
all: help

DOCKER_IMAGE="hello-world:0.1.0"
DEFAULT_NAMESPACE="dev"


cluster-up:
	@echo "Creating local cluster.."
	@kind create cluster

cluster-down:
	@echo "Deleting local cluster.."
	@kind delete cluster

img-build:
	@echo "Building $(DOCKER_IMAGE) Docker image.."
	@docker build -t $(DOCKER_IMAGE) -f ./docker/Dockerfile .

img-load:
	@echo "Loaidng $(DOCKER_IMAGE) Docker image.."
	@kind load docker-image $(DOCKER_IMAGE)

img-clean:
	@echo "Deleting $(DOCKER_IMAGE) Docker image.."
	@docker image rm $(DOCKER_IMAGE)

namespace:
	@# set K8S_NAMESPACE only if not exist
	@$(eval K8S_NAMESPACE ?= $(DEFAULT_NAMESPACE))

chart-install: namespace
	@echo "Installing Helm chart.."
	@echo "Using K8s namespace: $(K8S_NAMESPACE)"
	@helm install hello-world ./hello-chart --namespace $(K8S_NAMESPACE) --create-namespace

chart-update: namespace
	@echo "Updating Helm chart.."
	@echo "Using K8s namespace: $(K8S_NAMESPACE)"
	@helm upgrade hello-world ./hello-chart --namespace $(K8S_NAMESPACE)

url: namespace
	@export NODE_IP=$(kubectl get nodes --namespace $(K8S_NAMESPACE) -o jsonpath="{.items[0].status.addresses[0].address}")
	@export NODE_PORT=$(kubectl get --namespace $(K8S_NAMESPACE) -o jsonpath="{.spec.ports[0].nodePort}" services hello-world-hello-chart)
	@echo "URL: http://$(NODE_IP):$(NODE_PORT)"


help:
	@echo "Available make targets:"
	@echo " make help           - Print help"
	@echo " make cluster-up     - Create local cluster"
	@echo " make cluster-down   - Delete local cluster"
	@echo " make img-build      - Build $(DOCKER_IMAGE) Docker image"
	@echo " make img-load       - Load $(DOCKER_IMAGE) Docker image"
	@echo " make img-clean      - Delete $(DOCKER_IMAGE) Docker image"
	@echo " make chart-install  - Install Helm chart"
	@echo " make chart-update   - Update Helm chart"
	@echo ""
