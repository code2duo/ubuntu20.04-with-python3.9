FROM ubuntu:20.04

LABEL maintainer="Debdut Goswami - debdutgoswami@gmail.com"

ARG DEBIAN_FRONTEND_VARIABLE=noninteractive
ENV DEBIAN_FRONTEND=$DEBIAN_FRONTEND_VARIABLE

RUN apt-get update \
    && apt-get install -y python3-pip python3-dev libmysqlclient-dev netcat supervisor

# installing and upgrading to python3.9
# also install jdk and jre for java support
RUN apt update \
    && apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev \
    && wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz \
    && tar -xf Python-3.9.1.tgz \
    && cd Python-3.9.1 \
    && ./configure --enable-optimizations \
    && make \
    && make altinstall

# creating symlink between default python and python3.9
# basically replacing python3.8 with python3.9
RUN ln -s /usr/local/bin/python3.9 /usr/local/bin/python \
    && ln -s /usr/local/bin/python3.9 /usr/local/bin/python3 \
    && ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip \
    && pip install --upgrade pip

RUN rm -f -r Python-3.9.1 \
    && rm -f Python-3.9.1.tgz

#prepare for Java download
RUN apt-get install -y software-properties-common

#grab oracle java (auto accept licence)
RUN add-apt-repository -y ppa:linuxuprising/java
RUN apt-get update
RUN echo oracle-java15-installer shared/accepted-oracle-license-v1-2 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java15-installer

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
