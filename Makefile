# Load variables from .env
include .env
export $(shell sed 's/=.*//' .env)

# Variables
IMAGE_NAME = jupyter-server
CONTAINER_NAME ?= $(DOCKER_CONTAINER_NAME)
PORT ?= $(DOCKER_PORT)

# Check required variables
check-env:
	@echo "Validating environment variables..."
	@if [ -z "$(DOCKER_CONTAINER_NAME)" ]; then \
	  echo "Error: CONTAINER_NAME is not set in .env"; \
	  exit 1; \
	fi
	@if [ -z "$(DOCKER_PORT)" ]; then \
	  echo "Error: PORT is not set in .env"; \
	  exit 1; \
	fi
	@if [ -z "$(JUPYTER_PASSWORD)" ]; then \
	  echo "Error: JUPYTER_PASSWORD is not set in .env"; \
	  exit 1; \
	fi
	@echo "Environment variables are valid."

# Build the Docker image
db: check-env
	@echo "Building the Docker image..."
	docker build -t $(IMAGE_NAME) .

# Run the Docker container
dr: check-env
	@echo "Running the Docker container..."
	-docker stop $(CONTAINER_NAME) || true
	-docker rm $(CONTAINER_NAME) || true
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):8888 -v $(PWD):/app $(IMAGE_NAME)
	@echo "Jupyter Lab is running at http://localhost:$(PORT)"

# Stop the Docker container
ds:
	@echo "Stopping the Docker container..."
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

# Destroy the Docker image
dd:
	@echo "Destroying the Docker image and container..."
	-docker stop $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)
	docker rmi $(IMAGE_NAME)

# Enter the running container
de: check-env
	@echo "Creating a console inside the container..."
	docker exec -it $(CONTAINER_NAME) /bin/bash
