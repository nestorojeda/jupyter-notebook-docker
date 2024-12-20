#!/bin/bash

# Load environment variables from the .env file
if [ -f /app/.env ]; then
    export $(grep -v '^#' /app/.env | xargs)
fi

# Generate the Jupyter password hash
if [ -n "$JUPYTER_PASSWORD" ]; then
    HASHED_PASSWORD=$(python3 -c "from jupyter_server.auth import passwd; print(passwd('$JUPYTER_PASSWORD'))")
    mkdir -p ~/.jupyter
    echo "c.NotebookApp.password = u'$HASHED_PASSWORD'" > ~/.jupyter/jupyter_notebook_config.py
else
    echo "Error: JUPYTER_PASSWORD is not set in the .env file."
    exit 1
fi

# Start Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
