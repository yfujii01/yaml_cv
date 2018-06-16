FROM ruby:2.5.1-alpine

# データコピー
ADD ./data /data
ADD ./fonts /fonts
ADD ./out /out
ADD ./src /src
ADD ./exec.sh /exec.sh

# gem install
RUN gem install prawn --no-document
