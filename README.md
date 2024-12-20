# Jupyter Notebook Docker

I wanted to explore other alternatives to Google Colab, and have the ability to run Jupyter notebooks on my local computer or in a Github Codespaces. This repository contains the necessary files to set up a Jupyter Notebook environment using Docker.

## Prerequisites

- Docker installed on your machine
- Basic knowledge of Docker and Jupyter Notebook
- Tested in macOS and Windows using WSL

## Getting Started

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/jupyter-notebook-docker.git
    cd jupyter-notebook-docker
    ```

2. Copy the content of the .env.example file and add a password.

3. Build the Docker image:
    ```sh
    make db
    ```

4. Run the Docker container:
    ```sh
    make dr
    ```

5. Open your web browser and navigate to `http://localhost:8888`. You should see the Jupyter Notebook interface.

## Customization

You can customize the Dockerfile to include additional Python packages or Jupyter extensions as needed.

## Contributing

Feel free to submit issues or pull requests if you have any improvements or suggestions.