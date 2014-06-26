#!/bin/bash
# script : psql_change_password.sh
# author: Alain Dejoux <adejoux@krystalia.net>

# variables
basedir=$(dirname $0)

dbuser=$1

if [[ -z $dbuser ]]
then  
  echo "error: you need to provide the user name ! "
  echo "usage: $0 [user]"
  exit 1
fi

read -s -p "Enter new password: " password
echo
read -s -p "Confirm password:" check_password
echo

if [[ "$password" != "$check_password" ]]
then
  echo "error: passwords doesn't match!"
  exit 2
fi

if [[ ! -x ${basedir}/psql_connect.sh ]]
then
  echo "error: unable to find psql_connect.sh script in $basedir"
  exit 3
fi

echo "changing password for $dbuser"
echo "alter user $dbuser with password '$password';"|${basedir}/psql_connect.sh
