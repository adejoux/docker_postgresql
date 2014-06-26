introduction
============

It's a simple test to create a docker container containing a postgresql instance.

Configuration
==============

It's possible to customize some parameters in **config.env** file :

~~~
DATA_DIR="/data/postgresql"
DBUSER="pgadmin"
DBPASS="pgpass"
DBHOST="localhost"
DBPORT="5432"
~~~

The file will be copied in the docker image and used to set up the admin user and password. So modify it before generating the image.

Installation
============

Build image :

~~~
sudo docker build -t adejoux/postgresql .
~~~

Or pull the image :

~~~
sudo docker pull adejoux/postgresql
~~~

Usage
=======

Run the container :

~~~
sudo docker run -d -p 5432:5432 -v /data:/data adejoux/postgresql
~~~


Files
========

- **config.env** : configuration parameters
- **psql_connect.sh** : a wrapper to connect with psql
- **psql_change_password.sh** : a script to change user password after setup [recommended]
- **start.sh** : the script run when the container is started
