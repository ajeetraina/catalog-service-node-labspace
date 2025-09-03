# Adding Products to the Catalog

Let's access the Web Client

- Open the web client (http://localhost:5173) and create a few products.

### Accessing the database visualizer 

- Open [http://localhost:5050](http://localhost:5050) and validate the products exist in the database. 
"Good! We see the UPCs are persisted in the database"

- Use "postgres" as password to enter into the visualizer.

- Use the following Postgres CLI to check if the products are added or not.

```
# psql -U postgres
psql (17.1 (Debian 17.1-1.pgdg120+1))
Type "help" for help
postgres=# \c catalog
You are now connected to database "catalog" as user "postgres".
catalog=# SELECT * FROM products;
  1 | New Product | 100000000001 | 100.00 | f
  2 | New Product | 100000000002 | 100.00 | f
  3 | New Product | 100000000003 | 100.00 | f
```



### Access the Kafka Visualizer

Before we access visualizer, let's apply the patch:



Open the Kafka visualizer [http://localhost:8080](http://localhost:8080) and look at the published messages. 
"Ah! We see the messages don't have the UPC"

## Let's fix it...


### Configuring 

In VS Code, open the `src/services/ProductService.js` file and add the following to the publishEvent on line ~52:

```
upc: product.upc,
```

Save the file and create a new product using the web UI. 


Validate the message has the expected contents.

### Next Steps

In the next section, we'll see how to perform the integration testing using Testcontainers. Head over to [Testing apps](testing-app.md) to continue.

