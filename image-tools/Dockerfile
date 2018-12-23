FROM continuumio/anaconda3

RUN buildDeps='make automake autoconf libc6-dev gcc g++' \
    && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && apt-get -y install ghostscript libgs-dev \
    && apt-get -y --purge remove imagemagick \
    && git clone https://github.com/ImageMagick/ImageMagick.git \
    && cd ImageMagick && ./configure --with-gslib=yes \
    && make install \
    && conda update -y -n base conda \
    && conda install -y numpy pillow opencv \
    && rm -rf /var/lib/apt/lists/*
