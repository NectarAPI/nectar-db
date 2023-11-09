FROM postgres:14.9
LABEL org.opencontainers.image.authors="reagan@nectar.software"

COPY pg_hba.conf /etc/postgresql/14/main/
COPY postgresql.conf /etc/postgresql/14/main/
COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432