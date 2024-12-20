# Use the official Python base image
FROM python:3.9-slim

# Set environment variables to prevent interactive prompts and ensure UTF-8 locale
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Set a working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the entrypoint script
COPY start-jupyter.sh /app/
RUN chmod +x /app/start-jupyter.sh

# Expose the default Jupyter notebook port
EXPOSE 8888

# Start the Jupyter server using the script
CMD ["/app/start-jupyter.sh"]
