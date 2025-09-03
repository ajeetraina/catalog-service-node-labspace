# Docker Catalog Service Tutorial - Docker Labspace

Learn Docker by building and running a Node.js catalog service

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

## Author

Ajeet S Raina

---

*Original README content has been preserved in README.md.original*
