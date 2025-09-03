# Running with Docker Compose

Let's create a Docker Compose configuration for easier development.

## Creating docker-compose.yml

Create a docker-compose.yml file:

```bash
cat > docker-compose.yml << 'COMPOSE_END'
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
COMPOSE_END
```

## Starting with Docker Compose

Start all services:

```bash
docker compose up -d
```

## Viewing Service Status

Check the status of all services:

```bash
docker compose ps
```

## Viewing Logs

View logs from all services:

```bash
docker compose logs -f
```

## Stopping Services

When you're done, stop all services:

```bash
docker compose down
```
