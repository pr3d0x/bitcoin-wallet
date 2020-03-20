FROM juanluisbaptiste/xpra-base:latest
MAINTAINER Juan Luis Baptiste <juan.baptiste@gmail.com>
ENV BTC_VERSION "0.18.0"
ENV BTC_GUI_DOWNLOAD_URL https://bitcoin.org/bin/bitcoin-core-0.19.1/bitcoin-0.19.1-i686-pc-linux-gnu.tar.gz
COPY local-entrypoint.sh /

RUN apt-get update && \
    apt-get install -y curl zip libfontconfig1 libfreetype6 \
                       libegl1-mesa libgl1-mesa-glx && \
    apt-get clean && \
    chmod 755 /local-entrypoint.sh

USER user
WORKDIR /home/user
RUN curl ${BTC_GUI_DOWNLOAD_URL} -O
RUN tar zxf bitcoin-0.19.1-i686-pc-linux-gnu.tar.gz && \
    mv bitcoin-0.19.1 bitcoin-core && \
    rm bitcoin-0.19.1-i686-pc-linux-gnu.tar.gz && \
    mkdir .bitcoin

CMD ["/local-entrypoint.sh"]
EXPOSE 10000
