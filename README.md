# docker-rails-example
Rails application development and deployment with docker.

## Development
Start the services:
```sh
$ docker-compose up -d
```

Create the database:
```sh
$ docker-compose run --rm web bin/rails db:create
```

## Production
Deploy the applocation via `stack.yml` into a swarm cluster.

[![Try in PWD](https://cdn.rawgit.com/play-with-docker/stacks/cff22438/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/f-mer/docker-rails-example/master/stack.yml)

or

deploy the services via the CLI
```sh
$ docker stack deploy -c stack.yml rails
```

After deploying the application with PWD or manually the database has to be created.
```sh
$ cname=$(docker ps --format '{{.Names}}' | grep 'web' | head -1)
$ docker exec $cname bin/rails db:create
```

Make sure everything works as expected by visiting the `/heatlh` endpoint and checking the container health via `docker ps`.

## See also
- [dockerfiles/rails](https://github.com/f-mer/dockerfiles/tree/master/rails) - Rails docker image based on alpine for development.
