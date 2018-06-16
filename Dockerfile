FROM alpine:3.7

# データコピー
# ADD ./data /data
# ADD ./fonts /
ADD ./out /out
ADD ./src /src

# パッケージ
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
RUN apk update
RUN apk add ruby
RUN apk add wget
RUN apk add unzip
RUN apk add make

# DNS設定
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

# フォント準備
RUN mkdir fonts
RUN wget https://oscdl.ipa.go.jp/IPAexfont/ipaexg00301.zip
RUN unzip ipaexg00301.zip
RUN mv ipaexg00301/ipaexg.ttf ./fonts/
RUN rm -rf ipaexg00301 ipaexg00301.zip
RUN wget https://oscdl.ipa.go.jp/IPAexfont/ipaexm00301.zip
RUN unzip ipaexm00301.zip
RUN mv ipaexm00301/ipaexm.ttf ./fonts/
RUN rm -rf ipaexm00301 ipaexm00301.zip

# gem install
RUN gem install prawn --no-document

CMD ping localhost
