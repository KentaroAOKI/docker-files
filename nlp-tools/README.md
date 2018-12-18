# Japanese NLP environment
Build the following functions and create a docker image.
* anaconda
* mecab
* mecab-ipadic-neologd
* gensim

## Build
The following is an example of a build. Create an image of Docker as "jpnlp".
```
docker build -t jpnlp japanese-nlp
```

## RUN
The following is an example of usage. Create Python code in the data directory and run it.
```
mkdir data
docker run -ti -v data:/data jpnlp
```
