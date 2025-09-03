# Building the Application

Now let's run our containerized application.

## Running the Container

Let's start our application in a container:

```bash
docker run -d -p 3000:3000 --name my-app-container my-app
```

## Checking Container Status

Verify the container is running:

```bash
docker ps
```

## Viewing Logs

Let's check the application logs:

```bash
docker logs my-app-container
```

## Testing the Application

Test if the application is responding:

```bash
curl http://localhost:3000
```

## Cleaning Up

When you're done testing, stop and remove the container:

```bash
docker stop my-app-container
docker rm my-app-container
```

