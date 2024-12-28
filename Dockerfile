# Use the official Python base image
FROM jupyter/base-notebook

# Set environment variables to prevent interactive prompts and ensure UTF-8 locale
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Set a working directory inside the container
WORKDIR /app

# Copy the entrypoint script
COPY  --chmod=755 start-jupyter.sh /app/

# Expose the default Jupyter notebook port
EXPOSE 8888

# Start the Jupyter server using the script
CMD ["/app/start-jupyter.sh"]
