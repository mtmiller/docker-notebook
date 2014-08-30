# Using the Ubuntu image
FROM ubuntu:14.04

MAINTAINER Mike Miller <mike@mtmxr.com>
 
# Make sure apt is up to date
RUN apt-get update
RUN apt-get upgrade -y
 
# Not essential, but wise to set the lang
RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
 
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
 
# Python binary dependencies, developer tools
RUN apt-get install -y -q build-essential make gcc zlib1g-dev git python python-dev python-pip
RUN apt-get install -y -q libzmq3-dev sqlite3 libsqlite3-dev pandoc libcurl4-openssl-dev nodejs

VOLUME /notebooks
WORKDIR /notebooks

RUN pip install ipython[notebook]

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
ENV PASSWORD Dont make this your default

ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD /notebook.sh
