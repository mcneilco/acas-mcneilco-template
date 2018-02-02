#!/bin/sh
DB_NAME=acas

mkdir -p ./conf/docker/postgres/environment
echo "POSTGRES_PASSWORD=`openssl rand -hex 16`" > ./conf/docker/postgres/environment/postgres.env

mkdir -p ./conf/docker/db/environment
echo "DB_NAME=$DB_NAME
DB_USER=acas_admin
DB_PASSWORD=`openssl rand -hex 16`" > ./conf/docker/db/environment/db.env

mkdir -p ./conf/docker/acas/environment
echo "ACAS=true
ACAS_DB_NAME=$DB_NAME
ACAS_SCHEMA=acas
ACAS_USERNAME=acas
ACAS_PASSWORD=`openssl rand -hex 16`" > ./conf/docker/acas/environment/acas.env

mkdir -p ./conf/docker/cmpdreg/environment
echo "CMPDREG=true
CMPDREG_DB_NAME=$DB_NAME
CMPDREG_SCHEMA=compound
CMPDREG_ADMIN_USERNAME=compound_admin
CMPDREG_ADMIN_PASSWORD=`openssl rand -hex 16` > ./conf/docker/cmpdreg/environment/cmpdreg.env
CMPDREG_USER_USERNAME=compound
CMPDREG_USER_PASSWORD=`openssl rand -hex 16` > ./conf/docker/cmpdreg/environment/cmpdreg.env
CMPDREG_DATABASE_DRIVER=org.postgresql.Driver
CMPDREG_DATABASE_URL=jdbc:postgresql://db:5432/${CMPDREG_DB_NAME}?searchpath=${CMPDREG_SCHEMA}
CMPDREG_VALIDATION_QUERY=select version()
CMPDREG_FLYWAY_LOCATION=com.labsynch.cmpdreg.db.migration.postgres,db/migration/postgres,db/migration/indigo/postgres
CMPDREG_HIBERNATE_DIALECT=org.hibernate.dialect.PostgreSQLDialect`" > ./conf/docker/cmpdreg/environment/cmpdreg.env

mkdir -p ./conf/docker/seurat/environment
echo "SEURAT=true
SEURAT_DB_NAME=$DB_NAME
SEURAT_SCHEMA=seurat
SEURAT_USERNAME=seurat
SEURAT_PASSWORD=`openssl rand -hex 16`" > ./conf/docker/seurat/environment/seurat.env

mkdir -p ./conf/docker/roo/environment
echo "HIBERNATE_DIALECT=org.hibernate.dialect.PostgreSQLDialect
DATABASE_DRIVER=org.postgresql.Driver
DATABASE_URL=jdbc:postgresql://db:5432/${ACAS_DB_NAME}
VALIDATION_QUERY=select version()
CATALINA_OPTS=\"-Xms512M -Xmx1536M -XX:MaxPermSize=512m\"
ACAS_FLYWAY_LOCATION=com.labsynch.labseer.db.migration.postgres,db/migration/postgres
" > ./conf/docker/roo/environment/roo.env
