FROM continuumio/anaconda3
RUN buildDeps='make libc6-dev gcc g++' \
    && set -x \
    && echo 'Installing Mecab' \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && apt-get -y install mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8 \
    && mkdir -p `mecab-config --dicdir` \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && /mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \
    && export VAL=`mecab-config --dicdir`/mecab-ipadic-neologd; sed -i 's#^\(dicdir\s*=\s*\).*$#\1'$VAL'#' /etc/mecabrc \
    && echo 'Installing Tika' \
    && apt-get -y install openjdk-8-jre-headless tesseract-ocr tesseract-ocr-eng tesseract-ocr-jpn \
    && curl --output /tmp/tika-server.jar http://search.maven.org/remotecontent?filepath=org/apache/tika/tika-server/1.16/tika-server-1.16.jar \
    && curl --output /tmp/tika-server.jar.md5 http://search.maven.org/remotecontent?filepath=org/apache/tika/tika-server/1.16/tika-server-1.16.jar.md5 \
    && echo 'Installing Python' \
    && apt-get install -y swig \
    && conda update -y -n base conda \
    && conda install -y -c anaconda gensim requests nltk \
    && conda install -y -c conda-forge tika \
    && pip install tinysegmenter sumy mecab-python3 langdetect \
    && python -m nltk.downloader all \
    && rm -rf /mecab-ipadic-neologdclone \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove $buildDeps