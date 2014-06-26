#!/bin/bash
# script : psql_connect.sh
# author: Alain Dejoux <adejoux@krystalia.net>

# variables
basedir=$(dirname $0)

# load config
if [[ ! -f ${basedir}/config.env ]]
then
  echo "unable to access file ${basedir}/config.env"
  exit 1
fi
. ${basedir}/config.env

#check variables
for var in DBHOST DBUSER DBPORT
do
  if [ ! -n "${!var:-}" ]
  then
    echo "$var is not set ! Check config.env file $basedir"
    exit 1
  fi
done


DB=${DBNAME:-template1}
psql -h $DBHOST -U $DBUSER -p $DBPORT $DB
