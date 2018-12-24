FROM continuumio/anaconda3

RUN buildDeps='make automake autoconf libc6-dev gcc g++' \
    && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && apt-get -y install ghostscript imagemagick libgs-dev \
    && git clone https://github.com/ImageMagick/ImageMagick.git \
    && cd ImageMagick && ./configure --with-gslib=yes \
    && make install \
    && cd .. && rm -r ImageMagick \
    && conda update -y -n base conda \
    && conda install -y numpy pillow opencv \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove $buildDeps
