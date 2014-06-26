FROM ubuntu:14.04
MAINTAINER Alain Dejoux <adejoux@krystalia.net>

# update packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# install postgresql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql postgresql-contrib

# define data volume
VOLUME ["/data"]

# add parameters
ADD config.env /config.env

# Set the default command to run when starting the container
ADD start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
