FROM ubuntu:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV LD_LIBLARY_PATH /usr/local/lib

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb

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

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
