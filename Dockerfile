FROM continuumio/anaconda3
RUN buildDeps='make libc6-dev gcc g++' \
    && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && apt-get -y install mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8 \
    && mkdir `mecab-config --dicdir` \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && /mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \
    && export VAL=`mecab-config --dicdir`/mecab-ipadic-neologd; sed -i 's#^\(dicdir\s*=\s*\).*$#\1'$VAL'#' /etc/mecabrc \
    && conda update -y -n base conda \
    && conda install -y -c anaconda gensim requests \
    && conda install -y -c conda-forge tika \
    && pip install tinysegmenter sumy mecab-python3 \
    && rm -rf /mecab-ipadic-neologdclone \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove $buildDeps