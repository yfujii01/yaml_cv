FROM alpine:3.7

# RUN mkdir /root/resume
# WORKDIR /root/resume

ADD data.yaml /
ADD make_cv.rb /
ADD style.txt /
ADD txt2yaml.rb /

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
RUN apk update
RUN apk add ruby
RUN apk add wget
RUN apk add unzip

RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

RUN mkdir fonts

RUN wget https://oscdl.ipa.go.jp/IPAexfont/ipaexg00301.zip
RUN unzip ipaexg00301.zip
RUN mv ipaexg00301/ipaexg.ttf ./fonts/
RUN rm -rf ipaexg00301 ipaexg00301.zip

RUN wget https://oscdl.ipa.go.jp/IPAexfont/ipaexm00301.zip
RUN unzip ipaexm00301.zip
RUN mv ipaexm00301/ipaexm.ttf ./fonts/
RUN rm -rf ipaexm00301 ipaexm00301.zip

RUN gem install prawn --no-document

CMD ping localhost
