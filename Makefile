# Variables
IMAGE_NAME = jupyter-server
CONTAINER_NAME = jupyter_container
PORT = 8888

# Build the Docker image
db:
	@echo "Building the Docker image..."
	docker build -t $(IMAGE_NAME) .

# Run the Docker container
dr:
	@echo "Running the Docker container..."
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
de:
	@echo "Creating a console inside the container..."
	docker exec -it $(CONTAINER_NAME) /bin/bash