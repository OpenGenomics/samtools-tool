FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y autoconf autoconf-archive g++ libbz2-dev liblzma-dev libncurses5-dev make python wget zlib1g-dev

WORKDIR /opt

# install htslib
RUN wget  https://github.com/samtools/htslib/archive/1.3.1.tar.gz && \
    tar -zxvf 1.3.1.tar.gz && \
    rm 1.3.1.tar.gz && \
    cd htslib-1.3.1 && \
    autoheader && \
    autoconf && \
    ./configure && \
    make && \
    make install

# Get autoconf files
RUN mkdir autoconf && \
    wget -O autoconf/ax_with_htslib.m4 https://github.com/samtools/samtools/files/62424/ax_with_htslib.m4.txt

# install samtools
RUN wget https://github.com/samtools/samtools/archive/1.3.1.tar.gz && \
    tar -zxvf 1.3.1.tar.gz && \
    rm 1.3.1.tar.gz && \
    cd samtools-1.3.1 && \ 
    autoheader && \
    aclocal -I../autoconf && \
    autoconf && \
    ./configure && \
    make && \
    make install
