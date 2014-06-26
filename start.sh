#!/bin/bash
# script : start.sh
# author: Alain Dejoux <adejoux@krystalia.net>

if [ ! -f config.env ]
then
  echo "no config.env file !"
  exit 1
fi

. ./config.env

if [ ! -d ${DATA_DIR} ]; then
  mkdir -p ${DATA_DIR}
  chown -R postgres ${DATA_DIR}
  chmod 700 ${DATA_DIR}

  su postgres -c "/usr/lib/postgresql/9.3/bin/pg_ctl -D ${DATA_DIR}/main initdb"
  
  #configure to use DATA_DIR 
  sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" ${DATA_DIR}/main/postgresql.conf
  echo "host    all    all    0.0.0.0/0    md5" >> ${DATA_DIR}/main/pg_hba.conf

  # Start PostgreSQL
  echo "Starting postgresql server for user creation"
  su postgres -c "/usr/lib/postgresql/9.3/bin/pg_ctl -D /data/postgresql/main start"
  sleep 1
  echo "Creating db user: $DBUSER"
  su postgres -c "psql -q <<-EOF
    DROP ROLE IF EXISTS $DBUSER;
    CREATE ROLE $DBUSER WITH ENCRYPTED PASSWORD '$DBPASS';
    ALTER ROLE $DBUSER WITH SUPERUSER;
    ALTER ROLE $DBUSER WITH LOGIN;
EOF"
  echo "Stopping postgresql server"
  su postgres -c "/usr/lib/postgresql/9.3/bin/pg_ctl -D /data/postgresql/main stop"
fi
# Start PostgreSQL in foreground
echo "Starting postgresql server"
su postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D ${DATA_DIR}/main "

