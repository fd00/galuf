#!/bin/bash -ex
git clone https://github.com/ruby/ruby.git
cd ruby
autoreconf -fiv
./configure
make
make test
