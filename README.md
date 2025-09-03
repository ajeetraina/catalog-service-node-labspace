# Product Catalog Service Tutorial - Docker Labspace

This is a comprehensive Docker demonstration project created by the Docker Team that showcases multiple Docker services and development practices in a single Node.js application. 
It serves as both a functional catalog service API and a learning resource for Docker-based development workflows.

## Core Architecture

API Service: A Node.js application that provides a product catalog API with the following data sources:
- PostgreSQL database for storing product data
- AWS S3 bucket for product image storage
- External inventory service for inventory data
- Kafka cluster for publishing product updates

## Running This Labspace

To run this labspace, you'll need Docker installed on your system.

### Quick Start

```bash
export CONTENT_REPO_URL=$(git remote get-url origin)
docker compose -f oci://dockersamples/labspace up -y
```

Then open your browser to [http://localhost:3030](http://localhost:3030)

### Development Mode

If you're developing this labspace content:

```bash
CONTENT_PATH=$PWD docker compose -f oci://dockersamples/labspace-content-dev up
```

## Labspace Structure

- `labspace.yaml` - Defines the labspace configuration
- `docs/` - Contains the tutorial markdown files
- Source code files - The application being taught

