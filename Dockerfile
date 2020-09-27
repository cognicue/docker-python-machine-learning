FROM debian:jessie-slim

MAINTAINER Fasih <fasih@email.com>

RUN echo 'deb http://ftp.de.debian.org/debian jessie main' >> /etc/apt/sources.list
RUN echo 'deb http://security.debian.org/debian-security jessie/updates main ' >> /etc/apt/sources.list
RUN echo 'deb http://ftp.de.debian.org/debian sid main' >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get -y install          \
        python3.8               \
        python3.8-dev           \
        python3.8-distutils     \
        build-essential         \
        libssl-dev              \
        libffi-dev              \
        libxml2-dev             \
        libxslt1-dev            \
        zlib1g-dev              \
        libpq-dev               \
        libjpeg-dev             \
        bash                    \
        wget


RUN wget https://bootstrap.pypa.io/get-pip.py

RUN python3.8 get-pip.py

RUN rm get-pip.py

RUN cd /usr/local/bin \
  && rm -f easy_install \
  && rm -f pip \
  && rm -f pydoc \
  && rm -f python

RUN cd /usr/local/bin \
  && ln -s easy_install-3.8 easy_install \
  && ln -s pip3.8 pip \
  && ln -s /usr/bin/pydoc3.8 pydoc \
  && ln -s /usr/bin/python3.8 python

RUN apt-get autoremove
RUN apt-get autoclean

RUN echo 'alias python=python3.8' >> ~/.bashrc

RUN pip install             \
        numpy               \
        scipy               \
        scikit-learn        \
        lxml                \
        uWSGI               \
        pandas              \
        pandas_schema       \
        Pillow              \
        praat-parselmouth   \
        psycopg2


CMD set PYTHONIOENCODING=utf-8
