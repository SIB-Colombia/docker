#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create 'dataportal' db
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE dataportal;
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in dataportal "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION postgis;
		CREATE EXTENSION hstore;
		CREATE EXTENSION postgis_topology;
		CREATE EXTENSION fuzzystrmatch;
		CREATE EXTENSION postgis_tiger_geocoder;
EOSQL
done