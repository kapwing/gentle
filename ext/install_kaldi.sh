#!/bin/bash

# Prepare Kaldi
rm -rf kaldi
git clone https://github.com/kaldi-asr/kaldi.git
cd kaldi/tools
make clean
make
cd ../src
# make clean (sometimes helpful after upgrading upstream?)
./configure --static --static-math=yes --static-fst=yes --use-cuda=no
make depend
cd ../../
