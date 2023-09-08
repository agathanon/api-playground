# API Playground
This is a mock API playground used for developing robust API wrappers and
other HTTP-related code.

The API is created and served using [Mockoon](https://mockoon.com). Latency,
timeouts, and outages are introduced at random with
[Toxiproxy](https://github.com/Shopify/toxiproxy).

If you wish to add your own toxics while the stack is running, the Toxiproxy
HTTP API is available at http://localhost:8474.

## Requirements
- Docker Compose

## Features
- JSON responses
- Randomized HTTP responses
- Randomized timeouts, latency, and outages

## Usage
```shell
docker compose up
```

Requests with random faults will be served at http://localhost:18080. The API
is accessible without Toxiproxy at http://localhost:3000, but will still throw
some bad response codes at random.

## Routes

### /users
The `/users` endpoint will return a JSON list of 50 users:
```json
[ { "id": "string", "username": "string" } ]
```

Randomly returns HTTP 500 and 502 status codes.

### /admin/users
The `/admin/users` endpoint will return a JSON list of 10 users:
```json
[ { "id": "string", "username": "string", "isAdmin": "boolean" } ]
```

Route will always return '401 - Unauthorized" unless an `Authorization` header
is sent with the following token:
- `Bearer e3797209-119e-4671-8792-3c9e29260b28`

## Shoutouts
There's not much info on running a Toxiproxy in a Docker Compose stack, so
the idea for the "toxifier" container came from
[John Muth](https://github.com/johnmuth/toxiproxy-docker-compose-example).
