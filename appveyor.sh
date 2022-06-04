#!/bin/bash -ex
git clone https://github.com/ruby/ruby.git
cd ruby
git log --max-count=1
gcc -v
./autogen.sh
./configure
make V=1
make V=1 test
