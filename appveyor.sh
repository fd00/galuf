#!/bin/bash -ex
git clone https://github.com/ruby/ruby.git
cd ruby
git log --max-count=1
./autogen.sh
./configure
make
./miniruby basictest/test.rb
make test || true
