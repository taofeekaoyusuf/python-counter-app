# Use an official Python image as the base image
FROM python:3.9-alpine

# Command to add a Label
LABEL maintainer="Taofeek A.O. Yusuf"

# Set the working directory
WORKDIR /app

# Install pip dependencies
RUN apk add --no-cache --update make build-base libffi-dev openssl-dev
RUN pip install pipenv

# Install the Python dependencies
RUN pip install --upgrade --user setuptools==58.3.0
RUN pipenv install

# Copy the Python code and dependencies
COPY requirements.txt requirements.txt
COPY server.py /app
COPY storage.py /app
COPY Pipfile /app
COPY Pipfile.lock /app
COPY requirements.txt /app

# Command to install the requirements
RUN export PYTHONPATH=/usr/bin/python & \
  sudo apt-get update & \
  sudo apt-get -y upgrade & \
  sudo apt-get install -y gnupg2 wget lsb-release & \
  apk add --update linux-headers & \
  pip3 install --upgrade pip & \
  pip3 install --trusted-host pypi.python.org -r requirements.txt & \
  rm -rf /var/lib/apt/lists/* 

# Set the environment variables
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV SERVER_HOST=0.0.0.0
ENV SERVER_PORT=80

# Start the server
CMD ["pipenv", "run", "python", "server.py"]
