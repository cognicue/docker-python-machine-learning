FROM debian:buster-slim

MAINTAINER Fasih <fasih@email.com>

RUN echo 'deb http://ftp.de.debian.org/debian buster main' >> /etc/apt/sources.list
RUN echo 'deb http://security.debian.org/debian-security buster/updates main ' >> /etc/apt/sources.list
RUN echo 'deb http://ftp.de.debian.org/debian sid main' >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get -o APT::Immediate-Configure=0 --no-install-recommends -y install \
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
        ffmpeg                  \
        bash                    \
        wget                    \
        wkhtmltopdf             \
        xauth                   \
        xvfb

RUN printf '#!/bin/bash\nxvfb-run -a --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf -q $*' > /usr/bin/wkhtmltopdf.sh
RUN chmod a+x /usr/bin/wkhtmltopdf.sh
RUN ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf


RUN wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py

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

RUN apt-get -y autoremove
RUN apt-get -y autoclean

RUN echo 'alias python=python3.8' >> ~/.bashrc

RUN pip install             \
        numpy               \
        scipy               \
        scikit-learn        \
        lxml                \
        uWSGI               \
        pandas              \
        pandas_schema       \
        pdfkit              \
        Pillow              \
        praat-parselmouth   \
        psycopg2            \
        ffmpeg-python


CMD set PYTHONIOENCODING=utf-8
