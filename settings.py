import os

# Server settings
def serverHost(SERVER_HOST):
    SERVER_HOST = "0.0.0.0"
    return SERVER_HOST


def serverPort(SERVER_PORT):
    SERVER_PORT = os.environ.get("SERVER_PORT", 80)
    return SERVER_PORT


# Redis settings
def redisHost(REDIS_HOST):
    REDIS_HOST = os.environ.get("REDIS_HOST", "localhost")
    return REDIS_HOST


def redisPort(REDIS_PORT):
    REDIS_PORT = 6379
    return REDIS_PORT


def redisPwd(REDIS_PWD):
    REDIS_PWD = "qwerty"
    return REDIS_PWD
