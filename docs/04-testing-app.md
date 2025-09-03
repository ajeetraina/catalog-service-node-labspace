# Testing and Debugging

Let's explore how to debug and test our containerized application.

## Interactive Container Access

Sometimes you need to access the container directly for debugging:

```bash
docker compose exec app /bin/sh
```

Inside the container, you can:
- Check file systems
- Run commands
- Debug issues

Exit the container:

```bash
exit
```

## Monitoring Resources

Check resource usage:

```bash
docker stats
```

## Running Tests

If your application has tests, you can run them in a container:

```bash
docker compose exec app npm test
```

## Debugging Common Issues

- **Port conflicts**: Make sure the ports aren't already in use
- **Volume mounts**: Verify file paths are correct
- **Environment variables**: Check all required variables are set
- **Dependencies**: Ensure all dependencies are properly installed
