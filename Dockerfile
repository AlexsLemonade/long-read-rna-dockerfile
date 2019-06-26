FROM ubuntu:16.04

RUN apt-get update -qq && \
    apt-get install -y \
    software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt update && \
    apt install -y python3.7

RUN apt-get update -qq && \
    apt-get install -y \
    ed \
    git \
    libssl-dev \
    libcurl4-openssl-dev \
    curl \
    unzip \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y bzip2

COPY CRAN.gpg .

RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get install -y lsb-release && \
    echo "deb https://cran.revolutionanalytics.com/bin/linux/ubuntu $(lsb_release -sc)/" \
    >> /etc/apt/sources.list.d/added_repos.list

RUN apt-key add CRAN.gpg

RUN apt-get update -qq

RUN apt-get install -y \
    mercurial \
    libcairo-dev \
    libedit-dev \
    lsb-release \
    python3 \
    python3-pip \
    python-pip \
    r-base-core=3.4.2-1xenial1 \
    r-base-dev=3.4.2-1xenial1 \
    libpq-dev \
    libxml2-dev

RUN groupadd user && useradd --create-home --home-dir /home/user -g user user
WORKDIR /home/user

RUN wget -q https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17_x64-linux.tar.bz2

RUN tar -jxvf minimap2-2.17_x64-linux.tar.bz2

RUN mv ./minimap2-2.17_x64-linux/minimap2 /usr/local/bin

RUN wget -q https://github.com/arq5x/bedtools2/releases/download/v2.28.0/bedtools-2.28.0.tar.gz

RUN tar -xzf bedtools-2.28.0.tar.gz

RUN cd bedtools2 && make

RUN mv bedtools2/bin/bedtools /usr/local/bin

RUN python2 -m pip install --upgrade pip

RUN apt-get install -y python-dev

RUN python2 -m pip install pybedtools

RUN python2 -m pip install numpy pyfasta

RUN wget -q https://github.com/dewyman/TranscriptClean/archive/master.zip

RUN unzip master.zip && rm master.zip

RUN wget -q https://github.com/dewyman/TALON/archive/master.zip

RUN unzip master.zip && rm master.zip

ENTRYPOINT []
