FROM postgres:14.9
LABEL org.opencontainers.image.authors="dev@nectar.software"

ARG CONFIG_SERVICE_DB_PASSWORD=nBo7CQ2n!9SM
ARG PAYMENTS_SERVICE_DB_PASSWORD=8V8^QjiyXGU4
ARG TOKENS_SERVICE_DB_PASSWORD=hQ*E7AF3j7I#
ARG USER_SERVICE_DB_PASSWORD=8qVi&H5DdU0q

COPY pg_hba.conf /etc/postgresql/14/main/
COPY postgresql.conf /etc/postgresql/14/main/

WORKDIR /

COPY init.sql .
COPY script.sh .
RUN chmod +x ./script.sh
RUN ./script.sh

RUN cp init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432