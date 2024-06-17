# Use the Python 3.8.14-slim base image
FROM python:3.8.14-slim

# Set build-time argument to suppress interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Set environment variable to ensure Python output is unbuffered
ENV PYTHONUNBUFFERED=1

# Install dependencies for Poetry and build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        libpq-dev \
        build-essential \
        curl && \
    pip install --no-cache-dir poetry && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /server
WORKDIR /server

# Copy the current directory contents into the container at /server
COPY . /server

# Install the dependencies using Poetry
RUN poetry install --only main

# Expose the PORT variable
EXPOSE ${PORT}

# Set entrypoint to use Poetry and run the app with the specified PORT
ENTRYPOINT ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port"]

# Default CMD to pass the PORT environment variable
CMD ["8000"]
