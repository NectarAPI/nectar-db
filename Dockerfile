FROM postgres:14.9
LABEL org.opencontainers.image.authors="dev@nectar.software"

ARG CONFIG_SERVICE_DB_PASSWORD=<enter password>
ARG PAYMENTS_SERVICE_DB_PASSWORD=<enter password>
ARG TOKENS_SERVICE_DB_PASSWORD=<enter password>
ARG USER_SERVICE_DB_PASSWORD=<enter password>

COPY pg_hba.conf /etc/postgresql/14/main/
COPY postgresql.conf /etc/postgresql/14/main/

WORKDIR /

COPY init.sql .
COPY script.sh .
RUN chmod +x ./script.sh
RUN ./script.sh

RUN cp init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432