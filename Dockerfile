# Using the Debian unstable image
FROM debian:unstable

MAINTAINER Mike Miller <mike@mtmxr.com>
 
# Make sure apt is up to date
RUN apt-get update
RUN apt-get upgrade -y
 
# Not essential, but wise to set the lang
RUN apt-get install -y locales
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
 
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
 
# Python binary dependencies, developer tools
RUN apt-get install -y -q build-essential python3 python3-dev python3-pip
RUN apt-get install -y -q libzmq3-dev

VOLUME /notebooks
WORKDIR /notebooks

RUN pip3 install ipython[all]

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
ENV PASSWORD Dont make this your default

ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD /notebook.sh
