FROM postgres:14.9
LABEL org.opencontainers.image.authors="reagan@nectar.software"

ARG BEES_DB_PASSWORD=&JherU897@^Df
ARG BLOG_DB_PASSWORD=^yW4p7D7$x4P
ARG CONFIG_SERVICE_DB_PASSWORD=nBo7CQ2n!9SM
ARG NECTAR_DB_PASSWORD=zfCGt93O9g*c
ARG PAYMENTS_SERVICE_DB_PASSWORD=8V8^QjiyXGU4
ARG TOKENS_SERVICE_DB_PASSWORD=hQ*E7AF3j7I#
ARG USER_SERVICE_DB_PASSWORD=8qVi&H5DdU0q
ARG WEB_DB_PASSWORD=9lYleg46IU6@

COPY script.sh .
RUN chmod +x script.sh
RUN script.sh

COPY pg_hba.conf /etc/postgresql/14/main/
COPY postgresql.conf /etc/postgresql/14/main/
COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432