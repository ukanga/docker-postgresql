FROM stackbrew/ubuntu

MAINTAINER Ukang'a Dickson

EXPOSE 5432

VOLUME ["/var/lib/postgres/data"]

ENV USERNAME dbusername
ENV PASS dbpasswd
ENV CODENAME precise

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $CODENAME-pgdg main" > /etc/apt/sources.list.d/pgdg.list

ADD apt.postgresql.org.gpg /apt.postgresql.org.gpg
ENV KEYRING /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg
RUN test -e $KEYRING || touch $KEYRING
RUN apt-key --keyring $KEYRING add /apt.postgresql.org.gpg
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

RUN mkdir -p /data/postgres
ADD pg_hba.conf /data/postgres/pg_hba.conf
ADD postgresql.conf /data/postgres/postgresql.conf

ADD start /start
RUN chmod 0755 /start

# Cleanup
RUN apt-get clean

CMD ["/start"]
