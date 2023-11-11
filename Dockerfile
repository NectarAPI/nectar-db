FROM postgres:14.9
LABEL org.opencontainers.image.authors="reagan@nectar.software"

ARG BEES_DB_PASSWORD
ARG BLOG_DB_PASSWORD
ARG CONFIG_SERVICE_DB_PASSWORD
ARG NECTAR_DB_PASSWORD
ARG PAYMENTS_SERVICE_DB_PASSWORD
ARG TOKENS_SERVICE_DB_PASSWORD
ARG USER_SERVICE_DB_PASSWORD
ARG WEB_DB_PASSWORD


COPY pg_hba.conf /etc/postgresql/14/main/
COPY postgresql.conf /etc/postgresql/14/main/
COPY init.sql /docker-entrypoint-initdb.d/

WORKDIR /scripts
COPY script.sh .
RUN chmod +x script.sh
RUN /scripts/script.sh PG_TABLE "${PG_TABLE}"

EXPOSE 5432