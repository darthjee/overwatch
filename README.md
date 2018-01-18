# Overwatch

## Running
### With Docker
This project uses [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/)
so in order to run it, you first need to create a network

```bash
docker network create overwatch
```

Ensure the database will use a free port
```bash
export OVERWATCH_POSTGRES_PORT=5555
```

then you are ready to run

```bash
docker-compose up overwatch_app
```

you want to develop, anytime you add gems, don't forget to run

```bash
docker-compose run overwatch_root bundle install
```

if you want to import a file such as a CSV with users, run

```bash
docker-compose run overwatch_app rake importer:import[user,path_to_user.csv]
```

in order to run the tests run

```bash
docker-compose run overwatch_tests
```
you can access the running server at ```http://localhost:3000```

### Without Docker
If you don't want to run Docker, then you should make sure your machine has the following

 - [rvm](https://rvm.io/rvm/install) (or other ruby virtual machine)
 - ruby 2.4.0
 - postgresql >= 9.5

then export your postgres information

```bash
export OVERWATCH_POSTGRES_HOST=localhost
export OVERWATCH_POSTGRES_PORT=5432
export OVERWATCH_POSTGRES_USER=postgres
export OVERWATCH_POSTGRES_PASSWORD=postgres
export OVERWATCH_POSTGRES_NAME=overwatch
```

install your gems

```bash
bundle install
```

and construct the database

```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

if needing to inport more files (such as users.csv), run

```bash
rake importer:import[user,path_to_user.csv]
```

spin up the server

```bash
rails s
```

you are ready to test it at ```http://localhost:3000```
