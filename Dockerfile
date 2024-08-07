FROM ubuntu:18.04

RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y \
  gcc g++ gfortran \
  libc++-dev \
  libstdc++-6-dev zlib1g-dev \
  automake autoconf libtool \
  git subversion \
  libatlas3-base \
  nvidia-cuda-dev \
  ffmpeg \
  python3 python3-dev python3-pip \
  python python-dev python-pip \
  wget unzip \
  sox && \
  apt-get clean

ADD ext /gentle/ext
RUN export MAKEFLAGS=' -j8' &&  cd /gentle/ext && \
  ./install_kaldi.sh && \
  cd kaldi/tools/extras && \
  ./install_mkl.sh && \
  cd ../../src && \
  ./configure && \
  cd ../.. && \
  make depend && make && rm -rf kaldi *.o

ADD . /gentle
RUN cd /gentle && python3 setup.py bdist_wheel
RUN cd /gentle && pip3 install dist/*.whl

EXPOSE 8765

VOLUME /gentle/webdata

CMD cd /gentle && python3 serve.py
