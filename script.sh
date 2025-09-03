#!/bin/bash

# Product Catalog Labspace Content Updater
# Updates the generic labspace content with specific Product Catalog workshop content

set -e

# Configuration
LABSPACE_DIR="${1:-catalog-service-node-labspace}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Validate labspace directory exists
if [[ ! -d "$LABSPACE_DIR" ]]; then
    print_error "Labspace directory '$LABSPACE_DIR' does not exist"
    exit 1
fi

if [[ ! -f "$LABSPACE_DIR/labspace.yaml" ]]; then
    print_error "Not a valid labspace directory (missing labspace.yaml)"
    exit 1
fi

print_status "Updating Product Catalog labspace content in: $LABSPACE_DIR"

# Update labspace.yaml with more specific content
cat > "$LABSPACE_DIR/labspace.yaml" << 'YAML_EOF'
title: Docker Product Catalog Service
description: |
  Learn Docker by building and running a comprehensive Node.js catalog service with PostgreSQL, 
  Kafka, S3, and debugging real-world issues in a containerized environment.
  
  This hands-on lab demonstrates modern application development with:
  - Microservices architecture with Node.js
  - PostgreSQL database integration
  - Kafka message streaming
  - S3 storage with LocalStack
  - Container debugging and testing
  - Real bug fixing in production-like environments
  
author: Ajeet S Raina
sections:
  - title: Introduction & Architecture
    contentPath: ./docs/01-introduction.md
  - title: Environment Setup
    contentPath: ./docs/02-environment-setup.md
  - title: Understanding the Application Stack
    contentPath: ./docs/03-application-stack.md
  - title: Running with Docker Compose
    contentPath: ./docs/04-docker-compose.md
  - title: Exploring the Services
    contentPath: ./docs/05-exploring-services.md
  - title: Debugging & Fixing Issues
    contentPath: ./docs/06-debugging-fixing.md
  - title: Testing & Validation
    contentPath: ./docs/07-testing-validation.md
  - title: Advanced Topics
    contentPath: ./docs/08-advanced-topics.md
YAML_EOF

print_success "Updated labspace.yaml"

# Create the docs directory
mkdir -p "$LABSPACE_DIR/docs"

# 01-introduction.md
cat > "$LABSPACE_DIR/docs/01-introduction.md" << 'INTRO_EOF'
# Introduction to Docker Product Catalog Service

Welcome to this comprehensive Docker workshop! You'll learn container technology by working with a real-world Node.js application that demonstrates modern microservices architecture.

## Application Architecture

The Product Catalog Service is a full-stack application that includes:

- **🚀 Node.js API Service** - RESTful catalog management
- **🐘 PostgreSQL Database** - Product data persistence  
- **📊 Kafka Message Streaming** - Event-driven architecture
- **☁️ S3 Storage** - Product image storage (via LocalStack)
- **🔍 Database Visualizer** - pgAdmin for database inspection
- **📈 Kafka Visualizer** - Real-time message monitoring

## What You'll Learn

### Docker Fundamentals
- Container orchestration with Docker Compose
- Multi-service application deployment
- Volume and network management
- Environment configuration

### Real-World Development
- Debugging containerized applications
- Service-to-service communication
- Database integration in containers
- Message queue implementation

### Production-Ready Skills
- Health checks and monitoring
- Log aggregation and debugging
- Performance optimization
- Security best practices

## Workshop Scenario

You're a developer who needs to:
1. **Set up** a complex development environment quickly
2. **Debug** a production issue with missing data in Kafka messages
3. **Test** your fix across multiple services
4. **Validate** the complete application stack

## Prerequisites

- Basic Docker knowledge (containers, images, commands)
- Familiarity with Node.js applications
- Understanding of REST APIs
- Basic terminal/command line skills

## Lab Environment

This lab runs entirely in containers, giving you:
- ✅ Consistent environment across all systems
- ✅ No need to install Node.js, PostgreSQL, or Kafka locally
- ✅ Easy cleanup when done
- ✅ Production-like experience

Ready to dive in? Let's get started! 🚀
INTRO_EOF

# 02-environment-setup.md
cat > "$LABSPACE_DIR/docs/02-environment-setup.md" << 'SETUP_EOF'
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
SETUP_EOF

# Continue with remaining files...
create_remaining_docs "$LABSPACE_DIR/docs"

print_success "Updated all documentation files"
print_status ""
print_status "Product Catalog labspace content has been updated!"
print_status "The labspace now includes:"
print_status "• Real-world Node.js microservices architecture"
print_status "• PostgreSQL, Kafka, and S3 integration"
print_status "• Hands-on debugging exercises"
print_status "• Production-ready development practices"
print_status ""
print_status "To test the updated content:"
print_status "1. Make sure your labspace is running"
print_status "2. Refresh your browser at http://localhost:3030"
print_status "3. You should see the new, more comprehensive content"

create_remaining_docs() {
    local docs_dir="$1"
    
    # 03-application-stack.md
    cat > "$docs_dir/03-application-stack.md" << 'STACK_EOF'
# Understanding the Application Stack

Let's dive deep into the Product Catalog Service architecture and understand how each component works.

## Service Architecture Overview

Our application follows a microservices pattern with these key components:

```bash
# View the complete service architecture
docker compose ps --format "table {{.Name}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

## The Node.js API Service

Let's examine the main application service:

```bash
# Look at the main application entry point
cat src/app.js
```

```bash
# Check the product service logic
cat src/services/ProductService.js
```

### Key Features:
- **RESTful API** for product management
- **Database integration** with PostgreSQL
- **Event publishing** to Kafka
- **File upload** to S3 (LocalStack)
- **Structured logging** and error handling

## Database Layer (PostgreSQL)

Our application uses PostgreSQL for persistent storage:

```bash
# Connect to the database and explore
docker compose exec postgres psql -U postgres -d catalog
```

```sql
-- Inside the PostgreSQL prompt, explore the schema
\dt
\d products
SELECT COUNT(*) FROM products;
\q
```

## Message Streaming (Kafka)

Kafka handles event-driven communication:

```bash
# List available Kafka topics
docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list
```

```bash
# Create a topic for product events
docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --create --topic product-events --partitions 1 --replication-factor 1
```

## Storage Layer (LocalStack S3)

LocalStack provides S3-compatible object storage for development:

```bash
# Check LocalStack status
curl -s http://localhost:4566/_localstack/health | jq '.'
```

```bash
# List S3 buckets (should show product-images bucket)
docker compose exec localstack awslocal s3 ls
```

## Application Configuration

Let's examine how services are configured to work together:

```bash
# Check environment variables
cat .env || echo "No .env file - using defaults from docker-compose.yml"
```

```bash
# View the application configuration
grep -A 10 -B 5 "database\|kafka\|s3" src/config/database.js src/config/kafka.js 2>/dev/null || echo "Config files may be in different locations"
```

## Service Discovery and Communication

Each service communicates through Docker's internal network:

```bash
# Check the Docker network
docker network ls | grep catalog
docker network inspect $(docker compose ps --format json | jq -r '.[0].Networks' | head -1) | jq '.Containers | keys'
```

## Health Checks and Monitoring

Let's verify all services are healthy:

```bash
# Check container health status
docker compose ps
```

```bash
# View recent logs from all services
docker compose logs --tail=10 --follow
```

(Press Ctrl+C to stop following logs)

## Port Mapping and Access

Here are the key endpoints you can access:

- **API Service**: http://localhost:3000
- **Database Admin**: http://localhost:5050 (pgAdmin, password: `postgres`)
- **Kafka UI**: http://localhost:8080 (kafbat)
- **LocalStack**: http://localhost:4566 (S3 API)

## Testing Service Connectivity

Let's verify services can communicate:

```bash
# Test database connectivity from the app
npm run db:test 2>/dev/null || echo "Database test command not available - we'll test manually"
```

```bash
# Test Kafka connectivity
docker compose exec kafka kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test-topic
```

(Type a test message and press Enter, then Ctrl+C to exit)

## Next Steps

Now that you understand the architecture, let's start the application and see all these services working together in the next section.

Key takeaways:
- 🏗️ **Microservices**: Each component runs in its own container
- 🔗 **Service mesh**: All services communicate via Docker network
- 📊 **Event-driven**: Kafka enables loose coupling between services
- 💾 **Data persistence**: PostgreSQL + S3 for different data types
- 🔍 **Observability**: Built-in monitoring and logging tools
STACK_EOF

    # 04-docker-compose.md  
    cat > "$docs_dir/04-docker-compose.md" << 'COMPOSE_EOF'
# Running with Docker Compose

Now let's start the complete application stack and see everything working together.

## Understanding the Docker Compose File

First, let's examine our orchestration configuration:

```bash
# View the complete Docker Compose configuration
cat docker-compose.yml
```

Key observations:
- **Multi-stage service startup** (dependencies between services)
- **Volume mounts** for data persistence and development
- **Environment variables** for service configuration
- **Port mappings** for external access
- **Health checks** to ensure service readiness

## Starting the Complete Stack

Let's bring up all services in the correct order:

```bash
# Start all services (infrastructure first, then application)
docker compose up -d
```

Monitor the startup process:

```bash
# Watch services come online
watch -n 2 'docker compose ps'
```

(Press Ctrl+C to stop watching)

## Verifying Service Health

Let's ensure all services are running correctly:

```bash
# Check the status of all services
docker compose ps
```

```bash
# View startup logs for any issues
docker compose logs --tail=20
```

## Starting the Node.js Application

With the infrastructure running, let's start the API service:

```bash
# Start the development server
npm run dev
```

You should see output indicating:
- ✅ Database connection established
- ✅ Kafka producer initialized  
- ✅ S3 client configured
- ✅ Server listening on port 3000

## Testing the Application Stack

Let's verify everything is working by testing each component:

### 1. API Health Check

```bash
# Test the API is responding
curl -s http://localhost:3000/health | jq '.'
```

### 2. Database Connection

```bash
# Test database connectivity through the API
curl -s http://localhost:3000/api/products | jq '.'
```

### 3. Create a Test Product

```bash
# Create a new product via the API
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Product",
    "price": 99.99,
    "description": "A test product for Docker workshop"
  }' | jq '.'
```

### 4. Verify Data Persistence

```bash
# Check that the product was saved in the database
docker compose exec postgres psql -U postgres -d catalog -c "SELECT * FROM products;"
```

## Accessing the Web Interface

The application includes a React frontend for easier testing:

1. **Open the web client**: http://localhost:5173
2. **Create a few products** using the UI
3. **View the product catalog**

## Monitoring with Administrative Tools

### Database Administration (pgAdmin)

1. **Open pgAdmin**: http://localhost:5050
2. **Login**: Email: `admin@admin.com`, Password: `postgres`
3. **Connect to PostgreSQL**:
   - Host: `postgres` (service name)
   - Port: `5432`
   - Username: `postgres`
   - Password: `postgres`
   - Database: `catalog`

### Kafka Message Monitoring (kafbat)

1. **Open Kafka UI**: http://localhost:8080
2. **Browse Topics**: Look for `product-events` topic
3. **View Messages**: See real-time product creation events

## Understanding Service Logs

Let's look at how to monitor and debug the running services:

```bash
# View logs from a specific service
docker compose logs -f app
```

```bash
# View logs from multiple services
docker compose logs -f postgres kafka
```

```bash
# Search for specific log entries
docker compose logs | grep -i error
```

## Development Workflow

For active development, you can:

```bash
# Restart just the app service after code changes
docker compose restart app
```

```bash
# Rebuild and restart a service
docker compose up -d --build app
```

```bash
# Stop and remove all containers (keep data)
docker compose down
```

```bash
# Stop and remove everything including volumes (fresh start)
docker compose down --volumes
```

## Troubleshooting Common Issues

### Service Won't Start
```bash
# Check specific service logs
docker compose logs <service-name>

# Check resource usage
docker stats
```

### Port Conflicts
```bash
# Check what's using a port
lsof -i :3000
netstat -tulpn | grep :3000
```

### Database Connection Issues
```bash
# Test database connectivity
docker compose exec postgres pg_isready -U postgres
```

## Next Steps

Great! You now have a complete, multi-service application running in containers. In the next section, we'll explore each service in detail and learn how they communicate with each other.

**Current Status Check:**
- ✅ PostgreSQL database with product data
- ✅ Kafka streaming product events  
- ✅ S3-compatible storage ready
- ✅ Node.js API serving requests
- ✅ Web interface for interaction
- ✅ Administrative tools for monitoring

Ready to explore the services in action!
COMPOSE_EOF

    # 05-exploring-services.md
    cat > "$docs_dir/05-exploring-services.md" << 'EXPLORING_EOF'
# Exploring the Services

Now that everything is running, let's explore how the services work together and understand the data flow.

## Exploring the Web Interface

Let's create some test data and observe how it flows through our system:

1. **Open the web client**: http://localhost:5173
2. **Create several products** with different names and prices
3. **Browse the catalog** to see your products

```bash
# You can also create products via curl:
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Docker Workshop Mug",
    "price": 15.99,
    "description": "Perfect for your morning coffee while coding containers"
  }'
```

## Database Exploration

Let's see how product data is stored in PostgreSQL:

### Using pgAdmin (Web Interface)
1. **Open pgAdmin**: http://localhost:5050
2. **Login**: Email: `admin@admin.com`, Password: `postgres`
3. **Navigate to**: Servers → PostgreSQL → Databases → catalog → Schemas → public → Tables → products
4. **Right-click products** → View/Edit Data → All Rows

### Using Command Line
```bash
# Connect directly to the database
docker compose exec postgres psql -U postgres -d catalog
```

```sql
-- Inside PostgreSQL, explore the data:
SELECT * FROM products;

-- Check the table structure:
\d products

-- Count total products:
SELECT COUNT(*) FROM products;

-- Find products by price range:
SELECT name, price FROM products WHERE price > 50;

-- Exit PostgreSQL:
\q
```

### Verify UPC Storage
```bash
# Check if UPCs are being stored (spoiler: they should be!)
docker compose exec postgres psql -U postgres -d catalog -c "SELECT id, name, upc FROM products;"
```

You should see that products have UPC codes in the database. This is important for the debugging exercise coming up!

## Kafka Message Exploration

Let's examine the event-driven architecture by looking at Kafka messages:

### Using kafbat (Web Interface)
1. **Open Kafka UI**: http://localhost:8080
2. **Click on Topics** → Look for `product-events` topic
3. **Browse Messages** to see product creation events
4. **Examine message content** - Notice anything missing? 🤔

### Using Command Line
```bash
# List all Kafka topics
docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list
```

```bash
# Read messages from the product-events topic
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --from-beginning \
  --max-messages 5
```

### Create a New Product and Watch Kafka

Open two terminals:

**Terminal 1** (Message Consumer):
```bash
# Watch for new messages
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events
```

**Terminal 2** (Create Product):
```bash
# Create a new product
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Monitored Product",
    "price": 42.00,
    "description": "Watch this appear in Kafka!"
  }'
```

You should see the message appear immediately in Terminal 1! Press Ctrl+C to stop the consumer.

## S3 Storage Exploration

Let's check out the S3-compatible storage using LocalStack:

```bash
# Check LocalStack health
curl -s http://localhost:4566/_localstack/health | jq '.services'
```

```bash
# List S3 buckets
docker compose exec localstack awslocal s3 ls
```

```bash
# Check the product-images bucket contents
docker compose exec localstack awslocal s3 ls s3://product-images/
```

### Test File Upload
```bash
# Create a test file and upload it
echo "This is a test product image" > test-image.txt

# Upload to S3
docker compose exec -T localstack awslocal s3 cp - s3://product-images/test-image.txt < test-image.txt

# Verify it was uploaded
docker compose exec localstack awslocal s3 ls s3://product-images/
```

```bash
# Download and verify the file
docker compose exec localstack awslocal s3 cp s3://product-images/test-image.txt -
```

## Service Communication Patterns

Let's understand how services communicate:

### API → Database
```bash
# Check database connection from the app
curl -s http://localhost:3000/api/health | jq '.database'
```

### API → Kafka
```bash
# Create a product and immediately check Kafka
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Event Test", "price": 1.00}' && \
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --max-messages 1
```

### API → S3
```bash
# Test S3 connectivity through the API
curl -s http://localhost:3000/api/health | jq '.s3'
```

## Discovering the Bug 🐛

Now for the interesting part! Let's examine the Kafka messages more carefully:

```bash
# Look at recent Kafka messages and pay attention to the fields
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --from-beginning \
  --max-messages 3
```

**Question**: Do you notice something missing in the Kafka messages compared to what's stored in the database?

Let's compare:

```bash
# Database has UPC:
docker compose exec postgres psql -U postgres -d catalog -c "SELECT id, name, upc FROM products LIMIT 3;"
```

```bash
# But Kafka messages might not:
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --from-beginning \
  --max-messages 3
```

**🔍 Discovery**: The Kafka messages are missing the UPC field! This is our bug to fix.

## Application Logs Analysis

Let's look at the application logs to understand the flow:

```bash
# View recent application logs
docker compose logs --tail=20 app
```

```bash
# Follow live logs while creating a product
docker compose logs -f app &
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Debug Product", "price": 99.99}'

# Stop following logs
pkill -f "docker compose logs"
```

## Network Inspection

Let's understand how containers communicate:

```bash
# Check the Docker network
docker network ls | grep catalog
```

```bash
# Inspect the network to see connected containers
docker network inspect $(docker compose ps --format json | jq -r '.[0].Networks' | head -1 | tr -d '"')
```

## Performance Monitoring

```bash
# Check resource usage of all services
docker stats --no-stream
```

```bash
# Check specific service resource usage
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

## Next Steps

Great exploration! You've now:
- ✅ Created products through the web UI and API
- ✅ Verified data persistence in PostgreSQL  
- ✅ Observed event streaming through Kafka
- ✅ Tested S3 storage capabilities
- ✅ **Discovered a bug** - UPC missing from Kafka messages!

In the next section, we'll debug and fix this issue, learning valuable troubleshooting skills for containerized applications.

**The Bug Summary**: 
- 🟢 **Database**: Products have UPC codes
- 🔴 **Kafka**: Messages are missing UPC codes
- 🎯 **Mission**: Fix the ProductService to include UPC in Kafka messages

Ready to become a debugging hero? Let's fix this bug! 🛠️
EXPLORING_EOF

    # 06-debugging-fixing.md
    cat > "$docs_dir/06-debugging-fixing.md" << 'DEBUG_EOF'
# Debugging & Fixing Issues

Time to put on your detective hat! We've discovered that UPC codes are missing from Kafka messages. Let's debug and fix this issue.

## Understanding the Problem

Let's first confirm the bug exists:

### 1. Verify Database Has UPC
```bash
# Check that products in database have UPCs
docker compose exec postgres psql -U postgres -d catalog -c "SELECT id, name, upc FROM products LIMIT 5;"
```

### 2. Verify Kafka Messages Missing UPC
```bash
# Check recent Kafka messages
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --from-beginning \
  --max-messages 3
```

You should see messages like:
```json
{
  "id": 1,
  "name": "Test Product",
  "price": 99.99,
  "description": "A test product"
  // Notice: No "upc" field!
}
```

## Debugging the Code

Let's investigate where the issue might be:

### 1. Find the ProductService
```bash
# Locate the ProductService file
find . -name "*Product*" -type f | grep -v node_modules
```

### 2. Examine the ProductService Code
```bash
# Look at the ProductService implementation
cat src/services/ProductService.js
```

### 3. Focus on the publishEvent Method
```bash
# Find the publishEvent function specifically
grep -n -A 10 -B 5 "publishEvent" src/services/ProductService.js
```

You should see something like:
```javascript
async publishEvent(action, product) {
  const event = {
    action,
    product: {
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      // upc: product.upc,  <-- This line might be commented out or missing!
    },
    timestamp: new Date().toISOString()
  };
  
  await this.kafkaProducer.send({
    topic: 'product-events',
    messages: [{ value: JSON.stringify(event) }]
  });
}
```

## The Fix

Now let's fix the issue by adding the missing UPC field:

### 1. Edit the ProductService
```bash
# Open the ProductService in your editor (VS Code in the labspace)
code src/services/ProductService.js
```

### 2. Find the publishEvent Method
Look for the `publishEvent` method (around line 52) and find the product object being published.

### 3. Add the Missing UPC Field
Add this line to the product object in the publishEvent method:
```javascript
upc: product.upc,
```

The complete product object should look like:
```javascript
product: {
  id: product.id,
  name: product.name,
  price: product.price,
  description: product.description,
  upc: product.upc,  // <-- Add this line!
}
```

### 4. Save the File
Save the changes (Ctrl+S in VS Code).

## Testing the Fix

Let's verify our fix works:

### 1. Restart the Application
Since we're running in development mode with `npm run dev`, the application should automatically restart. If not:

```bash
# Stop the current process (Ctrl+C) and restart
npm run dev
```

### 2. Monitor Kafka Messages
Start monitoring Kafka messages in a separate terminal:

```bash
# Watch for new messages
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events
```

### 3. Create a Test Product
In another terminal, create a new product:

```bash
# Create a product to test the fix
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Fixed Product",
    "price": 123.45,
    "description": "This should have UPC in Kafka!"
  }'
```

### 4. Verify the Fix
Check the Kafka message that appears. You should now see:
```json
{
  "action": "created",
  "product": {
    "id": 6,
    "name": "Fixed Product",
    "price": 123.45,
    "description": "This should have UPC in Kafka!",
    "upc": "100000000006"  // <-- UPC is now present!
  },
  "timestamp": "2025-09-03T..."
}
```

🎉 **Success!** The UPC field is now included in Kafka messages!

## Advanced Debugging Techniques

Let's learn some additional debugging skills:

### 1. Application Logs Analysis
```bash
# View detailed application logs
docker compose logs --tail=50 app | grep -E "(error|warn|product)"
```

### 2. Real-time Log Monitoring
```bash
# Follow logs in real-time
docker compose logs -f app
```

### 3. Container Inspection
```bash
# Get detailed info about the app container
docker compose ps app
docker inspect $(docker compose ps -q app)
```

### 4. Environment Variable Debugging
```bash
# Check environment variables inside the container
docker compose exec app env | grep -E "(DATABASE|KAFKA|AWS)"
```

### 5. Network Connectivity Testing
```bash
# Test connectivity between services
docker compose exec app ping postgres
docker compose exec app nslookup kafka
```

## Testing Edge Cases

Let's test our fix thoroughly:

### 1. Bulk Product Creation
```bash
# Create multiple products quickly
for i in {1..3}; do
  curl -X POST http://localhost:3000/api/products \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"Bulk Product $i\", \"price\": $(($i * 10)).99}" &
done
wait
```

### 2. Check All Messages Have UPC
```bash
# Verify all recent messages include UPC
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --from-beginning | tail -10
```

## Performance Impact Analysis

Let's ensure our fix doesn't impact performance:

### 1. Response Time Testing
```bash
# Time the API response
time curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Performance Test", "price": 99.99}'
```

### 2. Resource Usage Check
```bash
# Check if resource usage changed
docker stats --no-stream app
```

## Code Quality Verification

### 1. Check for Syntax Errors
```bash
# Verify JavaScript syntax
node -c src/services/ProductService.js
echo "Syntax check passed!"
```

### 2. Look for Other Similar Issues
```bash
# Search for other places where UPC might be missing
grep -r "publishEvent\|product\." src/ --include="*.js" | grep -v upc
```

## Rollback Plan (If Needed)

If something goes wrong, here's how to rollback:

### 1. Git Status Check
```bash
# See what files were modified
git status
git diff src/services/ProductService.js
```

### 2. Revert Changes (If Needed)
```bash
# Only run this if you need to undo the changes
# git checkout -- src/services/ProductService.js
# npm run dev
```

## Debugging Best Practices Learned

✅ **Log Analysis** - Always check application logs first  
✅ **Data Flow Tracing** - Follow data through the entire pipeline  
✅ **Component Isolation** - Test each service individually  
✅ **Before/After Comparison** - Verify changes fix the issue  
✅ **Edge Case Testing** - Test multiple scenarios  
✅ **Performance Monitoring** - Ensure fixes don't degrade performance  
✅ **Documentation** - Document the fix for future reference  

## Next Steps

Excellent debugging work! 🎯 You successfully:
- ✅ **Identified** the missing UPC in Kafka messages
- ✅ **Located** the bug in ProductService.js
- ✅ **Fixed** the issue by adding the UPC field
- ✅ **Verified** the fix works correctly
- ✅ **Tested** thoroughly with multiple scenarios

In the next section, we'll run comprehensive tests to validate the entire application works perfectly!
DEBUG_EOF

    # 07-testing-validation.md
    cat > "$docs_dir/07-testing-validation.md" << 'TESTING_EOF'
# Testing & Validation

Now that we've fixed the UPC bug, let's run comprehensive tests to ensure our entire application works perfectly!

## End-to-End Testing

Let's test the complete data flow from API to database to Kafka:

### 1. Complete Workflow Test
```bash
# Create a product and track it through the entire system
PRODUCT_NAME="E2E Test Product $(date +%s)"
echo "Creating product: $PRODUCT_NAME"

# Create the product
RESPONSE=$(curl -s -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"$PRODUCT_NAME\", \"price\": 299.99, \"description\": \"End-to-end test product\"}")

echo "API Response: $RESPONSE"

# Extract the product ID
PRODUCT_ID=$(echo $RESPONSE | jq -r '.id')
echo "Product ID: $PRODUCT_ID"
```

### 2. Verify Database Storage
```bash
# Check the product was saved in the database
echo "Checking database..."
docker compose exec postgres psql -U postgres -d catalog -c \
  "SELECT id, name, upc, price FROM products WHERE id = $PRODUCT_ID;"
```

### 3. Verify Kafka Message
```bash
# Check the latest Kafka message
echo "Checking Kafka message..."
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --max-messages 1 \
  --timeout-ms 5000 | tail -1
```

## API Testing Suite

Let's test all API endpoints thoroughly:

### 1. Health Check
```bash
# Test application health
curl -s http://localhost:3000/health | jq '.'
```

### 2. Get All Products
```bash
# Test product listing
curl -s http://localhost:3000/api/products | jq '. | length'
echo "Total products found"
```

### 3. Get Single Product
```bash
# Test single product retrieval
curl -s http://localhost:3000/api/products/1 | jq '.name'
```

### 4. Create Product with Validation
```bash
# Test product creation with all fields
curl -s -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Validation Test Product",
    "price": 49.99,
    "description": "Testing all product fields",
    "category": "Electronics"
  }' | jq '.'
```

### 5. Error Handling Test
```bash
# Test error handling with invalid data
curl -s -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{"name": "", "price": -10}' | jq '.'
```

## Database Integration Testing

Let's thoroughly test database operations:

### 1. Data Integrity Check
```bash
# Verify all products have required fields
docker compose exec postgres psql -U postgres -d catalog -c \
  "SELECT 
     COUNT(*) as total_products,
     COUNT(upc) as products_with_upc,
     COUNT(name) as products_with_name,
     COUNT(price) as products_with_price
   FROM products;"
```

### 2. UPC Uniqueness Test
```bash
# Verify UPC codes are unique
docker compose exec postgres psql -U postgres -d catalog -c \
  "SELECT upc, COUNT(*) FROM products GROUP BY upc HAVING COUNT(*) > 1;"
```

If no rows are returned, all UPCs are unique! ✅

### 3. Data Types Validation
```bash
# Check data types are correct
docker compose exec postgres psql -U postgres -d catalog -c \
  "SELECT column_name, data_type FROM information_schema.columns 
   WHERE table_name = 'products';"
```

## Kafka Integration Testing

Let's verify event streaming works correctly:

### 1. Topic Health Check
```bash
# Verify product-events topic exists and is healthy
docker compose exec kafka kafka-topics.sh \
  --bootstrap-server localhost:9092 \
  --describe --topic product-events
```

### 2. Message Count Verification
```bash
# Count total messages in the topic
MESSAGE_COUNT=$(docker compose exec kafka kafka-run-class.sh kafka.tools.GetOffsetShell \
  --broker-list localhost:9092 \
  --topic product-events \
  --time -1 | awk -F: '{sum += $3} END {print sum}')

echo "Total messages in product-events topic: $MESSAGE_COUNT"
```

### 3. Message Format Validation
```bash
# Get the last few messages and validate they have UPC
echo "Validating message format..."
docker compose exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic product-events \
  --from-beginning \
  --max-messages 3 | jq -r '.product | if has("upc") then "✅ UPC present" else "❌ UPC missing" end'
```

## S3 Storage Testing

Let's test the S3 integration:

### 1. Bucket Verification
```bash
# Verify product-images bucket exists
docker compose exec localstack awslocal s3 ls | grep product-images
```

### 2. File Upload Test
```bash
# Test file upload capability
echo "Test image data" | docker compose exec -T localstack awslocal s3 cp - s3://product-images/test-upload.txt
```

### 3. File Retrieval Test
```bash
# Test file download capability
docker compose exec localstack awslocal s3 cp s3://product-images/test-upload.txt -
```

## Performance Testing

Let's run some basic performance tests:

### 1. Load Testing - Multiple Products
```bash
echo "Creating 10 products simultaneously..."
for i in {1..10}; do
  curl -s -X POST http://localhost:3000/api/products \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"Load Test Product $i\", \"price\": $((RANDOM % 100 + 10)).99}" &
done
wait
echo "Load test completed!"
```

### 2. Response Time Testing
```bash
# Measure response times
echo "Measuring API response times..."
for i in {1..5}; do
  echo -n "Request $i: "
  time (curl -s http://localhost:3000/api/products > /dev/null)
done
```

### 3. Resource Usage Check
```bash
# Check resource usage under load
echo "Current resource usage:"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"
```

## Web Interface Testing

Let's test the frontend application:

### 1. Frontend Health Check
```bash
# Test if the React app is accessible
curl -s -o /dev/null -w "%{http_code}" http://localhost:5173
echo " - Frontend HTTP status"
```

### 2. API Integration Test
Open http://localhost:5173 in your browser and:

1. **Create a product** using the web form
2. **View the product list** 
3. **Check that products appear immediately**

## Administrative Interface Testing

Let's verify monitoring tools work correctly:

### 1. pgAdmin Connection Test
```bash
echo "pgAdmin should be accessible at: http://localhost:5050"
echo "Login: admin@admin.com / postgres"
```

### 2. Kafka UI Test
```bash
echo "Kafka UI should be accessible at: http://localhost:8080"
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080
echo " - Kafka UI HTTP status"
```

## Integration Test Summary

Let's run a final comprehensive test:

```bash
echo "=== COMPREHENSIVE TEST SUMMARY ==="
echo ""

# 1. Service Health
echo "1. Service Health:"
docker compose ps --format "  {{.Name}}: {{.Status}}"
echo ""

# 2. API Health
echo "2. API Health:"
API_HEALTH=$(curl -s http://localhost:3000/health | jq -r '.status')
echo "  API Status: $API_HEALTH"
echo ""

# 3. Database Health
echo "3. Database Health:"
DB_COUNT=$(docker compose exec postgres psql -U postgres -d catalog -t -c "SELECT COUNT(*) FROM products;" | tr -d ' ')
echo "  Total Products: $DB_COUNT"
echo ""

# 4. Kafka Health
echo "4. Kafka Health:"
KAFKA_TOPICS=$(docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list | wc -l)
echo "  Active Topics: $KAFKA_TOPICS"
echo ""

# 5. S3 Health
echo "5. S3 Health:"
S3_STATUS=$(curl -s http://localhost:4566/_localstack/health | jq -r '.services.s3')
echo "  S3 Status: $S3_STATUS"
echo ""

echo "=== TEST COMPLETED ==="
```

## Test Results Validation

Your application passes all tests if you see:

- ✅ **All services**: Status "Up" or "running"
- ✅ **API Status**: "healthy"
- ✅ **Database**: Contains products with UPC codes
- ✅ **Kafka**: Messages include UPC field
- ✅ **S3**: Status "available"
- ✅ **Web UI**: Accessible and functional
- ✅ **Admin tools**: Accessible and connected

## Automated Testing Script

Here's a script to run all tests automatically:

```bash
cat > run_tests.sh << 'TEST_SCRIPT'
#!/bin/bash
echo "🧪 Running Product Catalog Test Suite..."

# Test API
echo "Testing API..."
curl -sf http://localhost:3000/health > /dev/null && echo "✅ API" || echo "❌ API"

# Test Database
echo "Testing Database..."
docker compose exec postgres pg_isready -U postgres > /dev/null && echo "✅ Database" || echo "❌ Database"

# Test Kafka
echo "Testing Kafka..."
docker compose exec kafka kafka-topics.sh --bootstrap-server localhost:9092 --list > /dev/null && echo "✅ Kafka" || echo "❌ Kafka"

# Test S3
echo "Testing S3..."
curl -sf http://localhost:4566/_localstack/health > /dev/null && echo "✅ S3" || echo "❌ S3"

echo "🎉 Test suite completed!"
TEST_SCRIPT

chmod +x run_tests.sh
./run_tests.sh
```

## Next Steps

Fantastic! 🎉 You've successfully:

- ✅ **Fixed the UPC bug** in Kafka messages
- ✅ **Validated end-to-end data flow**  
- ✅ **Tested all API endpoints**
- ✅ **Verified database integrity**
- ✅ **Confirmed Kafka event streaming**
- ✅ **Validated S3 storage**
- ✅ **Tested performance under load**
- ✅ **Verified monitoring tools**

Your Product Catalog Service is now fully functional and production-ready! In the final section, we'll explore advanced topics and next steps for taking this further.

**Key Achievement**: You've successfully debugged and validated a real-world, multi-service containerized application! 🚀
TESTING_EOF

    # 08-advanced-topics.md
    cat > "$docs_dir/08-advanced-topics.md" << 'ADVANCED_EOF'
# Advanced Topics

Congratulations on mastering the basics! Let's explore advanced Docker concepts and production-ready techniques.

## Production Deployment Strategies

### 1. Multi-Stage Docker Builds

Let's optimize our Docker image for production:

```bash
# Create an optimized production Dockerfile
cat > Dockerfile.production << 'PROD_DOCKERFILE'
# Multi-stage build for production
FROM node:18-alpine AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY src/ ./src/
# Add any build steps here if needed

FROM node:18-alpine AS runtime
WORKDIR /app

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001

# Copy only production dependencies
COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
COPY package*.json ./

# Security: Run as non-root user
USER nodejs

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

EXPOSE 3000
CMD ["npm", "start"]
PROD_DOCKERFILE
```

Build and test the production image:

```bash
# Build the production image
docker build -f Dockerfile.production -t catalog-service:prod .

# Compare image sizes
docker images | grep catalog-service
```

### 2. Docker Compose Override for Production

```bash
# Create production override
cat > docker-compose.prod.yml << 'PROD_COMPOSE'
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.production
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    deploy:
      replicas: 3
      resources:
        limits:
          cpus: '0.50'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  postgres:
    restart: unless-stopped
    volumes:
      - postgres_data:/var/lib/postgresql/data
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M

  kafka:
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 1G

volumes:
  postgres_data:
    external: true
PROD_COMPOSE

echo "Production compose file created!"
```

## Container Security Hardening

### 1. Security Scanning

```bash
# Scan the production image for vulnerabilities
docker scout quickview catalog-service:prod
```

```bash
# Get detailed vulnerability report
docker scout cves catalog-service:prod
```

### 2. Image Signing and Verification

```bash
# Sign the image (requires Docker Desktop Pro/Team)
# docker trust sign catalog-service:prod

# Verify image signatures
# docker trust inspect catalog-service:prod
```

### 3. Runtime Security

```bash
# Run container with security options
docker run -d --name secure-catalog \
  --read-only \
  --tmpfs /tmp \
  --tmpfs /var/run \
  --cap-drop ALL \
  --cap-add NET_BIND_SERVICE \
  --security-opt no-new-privileges:true \
  -p 3000:3000 \
  catalog-service:prod
```

## Monitoring and Observability

### 1. Application Metrics

Add monitoring to your application:

```bash
# Create a monitoring configuration
cat > docker-compose.monitoring.yml << 'MONITORING_COMPOSE'
version: '3.8'

services:
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3001:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana_data:/var/lib/grafana

volumes:
  grafana_data:
MONITORING_COMPOSE
```

```bash
# Create Prometheus configuration
cat > prometheus.yml << 'PROM_CONFIG'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'catalog-service'
    static_configs:
      - targets: ['host.docker.internal:3000']
    metrics_path: '/metrics'
PROM_CONFIG
```

### 2. Log Aggregation

```bash
# Add logging service
cat >> docker-compose.monitoring.yml << 'LOGGING_COMPOSE'

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.11.0
    environment:
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - xpack.security.enabled=false
    ports:
      - "9200:9200"

  kibana:
    image: docker.elastic.co/kibana/kibana:8.11.0
    ports:
      - "5601:5601"
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    depends_on:
      - elasticsearch
LOGGING_COMPOSE
```

## Scaling and High Availability

### 1. Load Balancer Configuration

```bash
# Create nginx load balancer configuration
mkdir -p nginx
cat > nginx/nginx.conf << 'NGINX_CONFIG'
upstream catalog_service {
    server app:3000;
    # Add more servers for scaling
    # server app2:3000;
    # server app3:3000;
}

server {
    listen 80;
    
    location / {
        proxy_pass http://catalog_service;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Health check
        proxy_connect_timeout 5s;
        proxy_send_timeout 10s;
        proxy_read_timeout 10s;
    }
    
    location /health {
        proxy_pass http://catalog_service/health;
        access_log off;
    }
}
NGINX_CONFIG
```

### 2. Database Replication

```bash
# Add read replica for PostgreSQL
cat > docker-compose.scale.yml << 'SCALE_COMPOSE'
version: '3.8'

services:
  postgres-primary:
    image: postgres:17.2
    environment:
      - POSTGRES_DB=catalog
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_REPLICATION_MODE=master
      - POSTGRES_REPLICATION_USER=replicator
      - POSTGRES_REPLICATION_PASSWORD=replicator_password

  postgres-replica:
    image: postgres:17.2
    environment:
      - PGUSER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_MASTER_SERVICE=postgres-primary
      - POSTGRES_REPLICATION_MODE=slave
      - POSTGRES_REPLICATION_USER=replicator
      - POSTGRES_REPLICATION_PASSWORD=replicator_password
    depends_on:
      - postgres-primary
SCALE_COMPOSE
```

## Advanced Networking

### 1. Custom Networks

```bash
# Create custom networks for better isolation
docker network create --driver bridge catalog-frontend
docker network create --driver bridge catalog-backend
```

```bash
# Update compose to use custom networks
cat >> docker-compose.yml << 'NETWORKS_COMPOSE'

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # No internet access

services:
  app:
    networks:
      - frontend
      - backend
  
  postgres:
    networks:
      - backend
  
  kafka:
    networks:
      - backend
NETWORKS_COMPOSE
```

### 2. Service Discovery

```bash
# Example of service discovery with Consul
cat > docker-compose.discovery.yml << 'DISCOVERY_COMPOSE'
version: '3.8'

services:
  consul:
    image: consul:1.15.2
    ports:
      - "8500:8500"
    environment:
      - CONSUL_BIND_INTERFACE=eth0
    command: consul agent -dev -client=0.0.0.0

  registrator:
    image: gliderlabs/registrator:latest
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock
    command: consul://consul:8500
    depends_on:
      - consul
DISCOVERY_COMPOSE
```

## CI/CD Pipeline Integration

### 1. GitHub Actions Workflow

```bash
# Create GitHub Actions workflow
mkdir -p .github/workflows
cat > .github/workflows/docker.yml << 'GITHUB_WORKFLOW'
name: Docker Build and Deploy

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v3
    
    - name: Login to Docker Hub
      uses: docker/login-action@v3
      with:
        username: ${{ secrets.DOCKERHUB_USERNAME }}
        password: ${{ secrets.DOCKERHUB_TOKEN }}
    
    - name: Build and test
      run: |
        docker compose -f docker-compose.test.yml up --build --abort-on-container-exit
    
    - name: Build and push production image
      uses: docker/build-push-action@v5
      with:
        context: .
        file: ./Dockerfile.production
        push: true
        tags: ${{ secrets.DOCKERHUB_USERNAME }}/catalog-service:latest
        cache-from: type=gha
        cache-to: type=gha,mode=max
GITHUB_WORKFLOW
```

### 2. Testing in CI

```bash
# Create test compose file
cat > docker-compose.test.yml << 'TEST_COMPOSE'
version: '3.8'

services:
  test-db:
    image: postgres:17.2
    environment:
      - POSTGRES_DB=catalog_test
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    tmpfs:
      - /var/lib/postgresql/data

  app-test:
    build:
      context: .
      dockerfile: Dockerfile.test
    environment:
      - NODE_ENV=test
      - DATABASE_URL=postgres://postgres:postgres@test-db:5432/catalog_test
    depends_on:
      - test-db
    command: npm test
TEST_COMPOSE
```

## Container Orchestration

### 1. Docker Swarm Mode

```bash
# Initialize Docker Swarm
docker swarm init

# Deploy as a stack
docker stack deploy -c docker-compose.yml catalog-stack

# Scale services
docker service scale catalog-stack_app=3

# View service status
docker service ls
docker service ps catalog-stack_app
```

### 2. Kubernetes Deployment

```bash
# Create Kubernetes manifests
mkdir -p k8s

# Deployment
cat > k8s/app-deployment.yaml << 'K8S_DEPLOYMENT'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: catalog-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: catalog-service
  template:
    metadata:
      labels:
        app: catalog-service
    spec:
      containers:
      - name: catalog-service
        image: catalog-service:prod
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
K8S_DEPLOYMENT

# Service
cat > k8s/app-service.yaml << 'K8S_SERVICE'
apiVersion: v1
kind: Service
metadata:
  name: catalog-service
spec:
  selector:
    app: catalog-service
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: LoadBalancer
K8S_SERVICE
```

## Performance Optimization

### 1. Resource Optimization

```bash
# Analyze resource usage
docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"

# Optimize memory usage
docker system df
docker system prune -a
```

### 2. Caching Strategies

```bash
# Add Redis for caching
cat >> docker-compose.yml << 'REDIS_COMPOSE'

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data

volumes:
  redis_data:
REDIS_COMPOSE
```

## Production Checklist

Before going to production, ensure you have:

### Security
- [ ] Multi-stage builds with minimal base images
- [ ] Non-root user execution
- [ ] Secrets management (not in environment variables)
- [ ] Container image scanning
- [ ] Network policies and firewalls
- [ ] SSL/TLS certificates

### Monitoring
- [ ] Application metrics (Prometheus/Grafana)
- [ ] Log aggregation (ELK stack)
- [ ] Health checks on all services
- [ ] Alerting for critical issues
- [ ] Performance monitoring

### Scalability
- [ ] Horizontal scaling capabilities
- [ ] Load balancer configuration
- [ ] Database replication/clustering
- [ ] Message queue clustering
- [ ] Auto-scaling policies

### Reliability
- [ ] Backup and restore procedures
- [ ] Disaster recovery plan
- [ ] Rolling deployment strategy
- [ ] Circuit breaker patterns
- [ ] Graceful shutdown handling

## Next Steps and Learning Path

🎓 **Congratulations!** You've completed the Docker Product Catalog workshop. Here's your learning path forward:

### Immediate Next Steps
1. **Deploy to cloud** (AWS ECS, Azure Container Instances, GCP Cloud Run)
2. **Implement monitoring** in a real environment
3. **Set up CI/CD pipeline** with GitHub Actions or GitLab CI
4. **Practice Kubernetes** deployment

### Advanced Topics to Explore
- **Service mesh** (Istio, Linkerd)
- **Container orchestration** at scale
- **Advanced security** (OPA, Falco)
- **Multi-cloud deployments**

### Recommended Resources
- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Learning Path](https://kubernetes.io/training/)
- [Cloud Native Computing Foundation](https://www.cncf.io/)
- [Docker Best Practices](https://docs.docker.com/develop/best-practices/)

## Final Summary

You've successfully:
- 🐳 **Mastered Docker fundamentals** with a real application
- 🔧 **Debugged and fixed** production issues  
- 🧪 **Implemented comprehensive testing**
- 🏗️ **Learned production deployment strategies**
- 📊 **Understood monitoring and observability**
- 🚀 **Explored advanced topics** for scalability

**You're now ready to confidently containerize and deploy applications in production!** 🎉

Thank you for completing the Docker Product Catalog workshop! Share your success and keep learning! 🚀
ADVANCED_EOF
}

print_success "Content update script created!"
print_status ""
print_status "To update your labspace with Product Catalog specific content:"
print_status "1. Make sure your labspace directory is: $LABSPACE_DIR"
print_status "2. Run this script to update the content"
print_status "3. Refresh your browser to see the new content"
print_status ""
print_status "The updated content includes:"
print_status "• Real Product Catalog workshop content"
print_status "• Hands-on debugging exercise (missing UPC in Kafka)"
print_status "• PostgreSQL, Kafka, S3, and pgAdmin integration"
print_status "• Production-ready development practices"
print_status "• Advanced topics for scaling and deployment"
