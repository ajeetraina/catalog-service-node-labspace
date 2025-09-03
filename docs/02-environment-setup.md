# Environment Setup

Let's get your development environment ready and understand what we're working with.

## Clone and Explore the Repository

First, let's examine the application structure:

```bash
ls -la
```

You should see the complete catalog service application with:
- `src/` - Node.js application source code
- `docker-compose.yml` - Multi-service container orchestration
- `Dockerfile` - Container image definition
- `package.json` - Node.js dependencies and scripts
- Database and messaging configurations

## Understanding the Project Structure

Let's explore the key components:

```bash
# Check the main application structure
find src -name "*.js" | head -10
```

```bash
# Look at the API routes
cat src/routes/productRoutes.js
```

```bash
# Examine the Docker Compose configuration
cat docker-compose.yml
```

## Initial Docker Compose Setup

The application comes with a complete Docker Compose setup. Let's examine what services we'll be running:

```bash
# See all the services defined
docker compose config --services
```

Expected services:
- **app** - Node.js API service
- **postgres** - Database
- **kafka** - Message streaming
- **localstack** - S3-compatible storage
- **pgadmin** - Database admin interface
- **kafbat** - Kafka monitoring UI

## Start the Supporting Services

Let's start all the supporting services (database, messaging, etc.) first:

```bash
docker compose up -d postgres kafka localstack pgadmin kafbat
```

Wait for services to be ready:

```bash
# Check that services are running
docker compose ps
```

```bash
# Check service logs to ensure they're healthy
docker compose logs postgres | tail -5
docker compose logs kafka | tail -5
```

## Install Application Dependencies

While the services start up, let's prepare the Node.js application:

```bash
# Install the application dependencies
npm install
```

```bash
# Check that everything installed correctly
npm list --depth=0
```

## Verify Service Health

Let's make sure our supporting services are ready:

```bash
# Test PostgreSQL connection
docker compose exec postgres psql -U postgres -c "SELECT version();"
```

```bash
# Check Kafka is responsive
docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list
```

## Next Steps

Great! Your environment is now set up with:
- ✅ All supporting services running in containers
- ✅ Node.js dependencies installed
- ✅ Database and messaging systems ready

In the next section, we'll dive deeper into the application architecture and understand how these services work together.
