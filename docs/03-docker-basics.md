# Docker Basics

Let's start by understanding the Docker configuration for this application.

## Examining the Dockerfile

Let's look at the existing Dockerfile:

```bash
cat Dockerfile
```

If you don't have a Dockerfile yet, let's create one for a Node.js application:

```bash
cat > Dockerfile << 'DOCKERFILE_END'
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
DOCKERFILE_END
```

## Building the Docker Image

Now let's build our Docker image:

```bash
docker build -t my-app .
```

Let's verify the image was created:

```bash
docker images | grep my-app
```
