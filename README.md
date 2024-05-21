# postgresql-db-versioning

Template repository which could be used to version-control the schema of your PostgreSQL database.


## How to use

Write your sql scripts in the `sql_files` directory. The scripts should be named alphabetically in the order you want them to be executed. For example, `01_create_table.sql`, `02_insert_data.sql`, `03_create_index.sql`, etc.

Best way to check the order of the scripts is to run the following command:

```bash
find ./sql_files -type f -name '*.sql' | sort
```

The above command will list all the sql files in the `sql_files` directory in the order they will be executed.

## How to run

To make life easier for dev, there is a docker-compose file which will create a PostgreSQL database and run the scripts in the `sql_files` directory for your testing.

Also the instance of pgAdmin is provided to connect to the database and check the schema.

To run the docker-compose file, run the following command:

```bash
docker-compose -f docker-compose.dev.yml up --build
```

For applying to real-life database either run this script with local psql tool or run it via docker using the docker-compose file.

I'll leave the rest to you.

## Note
- You probably want to remove .gitignore file in the `sql_files` directory to version-control the sql files.

### Pre-commit hooks

Make sure to install all pre-commit hooks using: `pre-commit install`

In addition to sql formatter, pre-commit hooks enforce conventional commit messages. Make sure to follow the convention when writing commit messages.