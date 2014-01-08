# Postgres 9.3 image

- Change `dbusername` and `dbpasswd` to appropriate username and passwords in `Dockerfile`

## Install postgres 9.3 image

    $ docker build -t USERNAME/postgres:9.3 .
    $ docker run -v "~/postgres/data":"/var/lib/postgres/data" -p 5432:5432 -d USERNAME/postgres:9.3
