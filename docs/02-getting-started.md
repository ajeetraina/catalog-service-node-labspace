# Getting Started

## Bring up the Compose Services


```bash
docker compose up -d --build
```

## Ensure that all services are running

```bash
  docker compose ps
```

## Bring up the main application

```bash
npm install --omit=optional
npm run dev
```

Once everything is up and running, you can open the demo client at http://localhost:5173



## Next Steps

In the next section, we'll start adding some products to our catalog. Head over to [Adding Products](./03-adding-products.md) to continue.

