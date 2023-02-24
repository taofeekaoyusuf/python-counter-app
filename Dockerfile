# Use an official Python image as the base image
FROM python:3.9.5-alpine

# Command to add a Label
LABEL maintainer="Taofeek A.O. Yusuf"

# Set the working directory
WORKDIR /app

# Copy the Python code and dependencies
COPY server.py /app
COPY settings.py /app
COPY storage.py /app
COPY Pipfile /app
COPY Pipfile.lock /app
COPY requirements.txt /app

# Command to install the requirements
RUN python -m pip install --upgrade pip && \
  # /usr/local/bin/python -m pip install --upgrade pip && export PYTHONPATH=/usr/bin/python && \ 
  pip3 install --trusted-host pypi.python.org -r requirements.txt && \
  rm -rf /var/lib/apt/lists/*

# Install the dependencies
RUN apk add --no-cache \
  redis \
  build-base \
  libffi-dev \
  openssl-dev \
  && pip install pipenv

# Install the Python dependencies
RUN pip install --upgrade --user setuptools==58.3.0
RUN pipenv install
# RUN pipenv install --ignore-pipfile

# Set the environment variables
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV SERVER_HOST=0.0.0.0
ENV SERVER_PORT=80

# Expose Ports
EXPOSE 80 6379

# Set Entry point
# ENTRYPOINT [ "server.py" ]

# Start the server
CMD ["pipenv", "run", "python", "server.py"]
