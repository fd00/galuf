#!/bin/bash -x
git clone https://github.com/ruby/ruby.git
cd ruby
./configure
make
make test
