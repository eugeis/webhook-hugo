# [Webhook](https://github.com/adnanh/webhook/) Dockerized with [Hugo](https://gohugo.io/)

The `hugo` application is inside of the docker image and can be used in web hook `command-execute` scripts.

## Running webhook in Docker

The simplest usage of [almir/webhook](https://hub.docker.com/r/almir/webhook/) image is for one to host the hooks JSON file on their machine and mount the directory in which those are kept as a volume to the Docker container:

    docker run -d -p 9000:9000 -v /dir/to/hooks/on/host:/etc/webhook --name=webhook \
      almir/webhook -verbose -hooks=/etc/webhook/hooks.json -hotreload

Another method of using this Docker image is to create a simple `Dockerfile`:

    FROM almir/webhook
    COPY hooks.json.example /etc/webhook/hooks.json

This `Dockerfile` and `hooks.json.example` files should be placed inside the same directory. After that run `docker build -t my-webhook-image .` and then start your container:

    docker run -d -p 9000:9000 --name=webhook my-webhook-image -verbose -hooks=/etc/webhook/hooks.json -hotreload

Additionally, one can specify the parameters to be passed to [webhook](https://github.com/adnanh/webhook/) in `Dockerfile` simply by adding one more line to the previous example:

    FROM almir/webhook
    COPY hooks.json.example /etc/webhook/hooks.json
    CMD ["-verbose", "-hooks=/etc/webhook/hooks.json", "-hotreload"]

Now, after building your Docker image with `docker build -t my-webhook-image .`, you can start your container by running just:

    docker run -d -p 9000:9000 --name=webhook my-webhook-image
