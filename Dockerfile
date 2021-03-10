FROM ubuntu:20.04

LABEL maintainer="Debdut Goswami - debdutgoswami@gmail.com"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip python3-dev libmysqlclient-dev netcat supervisor tzdata

# installing and upgrading to python3.9
# also install jdk and jre for java support
RUN apt update \
    && apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev default-jre default-jdk \
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

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
