FROM ubuntu:22.10

RUN apt-get update -q && \
    apt-get install -qy  git make g++ autoconf libtool pkg-config bsdmainutils libboost-all-dev libssl-dev libevent-dev libdb++-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean
WORKDIR /yantum
VOLUME /root/.yantum/
ADD . /yantum
RUN ./autogen.sh && ./configure --with-gui=no --with-incompatible-bdb --enable-static --disable-shared && make -j8 && cp src/yantum* /usr/local/bin/ && make distclean
CMD ["yantumd"]
