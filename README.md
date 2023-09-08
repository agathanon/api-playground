# API Playground
This is a mock API playground used for developing robust API wrappers and
other HTTP-related code.

## Requirements
Requires either [Mockoon Desktop](https://mockcoon.com/download) or
[Mockoon CLI](https://hub.docker.com/r/mockoon/cli).

## Features
- JSON responses
- Randomized HTTP responses

## Usage
Import the environment file [mockoon-env.json](mockoon-env.json) into Mockcoon Desktop and click "Start Server".


For a more simple deployment use Docker:
```shell
docker compose up
```

Requests will be served at http://localhost:3000 unless another port is specified
in the Mockcoon environment settings or the [docker-compose.yml](docker-compose.yml) file.

## Routes

### /users
The `/users` endpoint will return a JSON list of 50 users:
```json
[ { "id": "string", "username": "string" } ]
```

Randomly returns HTTP 500 and 502 status codes.

### /admin/users
The `/admin/users` endpoint will return a JSON list of 50 users:
```json
[ { "id": "string", "username": "string", "isAdmin": "boolean" } ]
```

Route will always return '401 - Unauthorized" unless an `Authorization` header
is sent with the following token:
- `Bearer e3797209-119e-4671-8792-3c9e29260b28`
