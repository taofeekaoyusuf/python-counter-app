import os
import json
from klein import Klein
from storage import Storage

# Server settings
SERVER_HOST = "0.0.0.0"
SERVER_PORT = os.environ.get("SERVER_PORT", 80)

# Redis settings
REDIS_HOST = os.environ.get("REDIS_HOST", "localhost")
REDIS_PORT = 6379
REDIS_PWD = "qwerty"

app = Klein()
storage = Storage(REDIS_HOST, REDIS_PORT, REDIS_PWD)


@app.route('/')
def counter(request):
    """
    Base endpoint to get current counter value
    :param request:
    :return: JSON representation of response
    """
    return json.dumps({"counter": int(storage.read())})


@app.route('/increment', methods=['POST'])
def increment(request):
    """
    Endpoint to increment the counter
    :param request:
    :return: JSON representation of response
    """
    return json.dumps({"counter": int(storage.incr())})


@app.route('/increment', methods=['DELETE'])
def reset(request):
    """
    Endpoint to reset the counter
    :param request:
    :return: JSON representation of response
    """
    return json.dumps({"counter": int(storage.reset())})


if __name__ == "__main__":
    app.run(SERVER_HOST, SERVER_PORT)
