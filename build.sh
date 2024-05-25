#!/bin/bash
git clone --depth=1 https://github.com/ruby/ruby.git
cd ruby
git log --max-count=1
./autogen.sh
./configure --disable-install-rdoc
make -j2 V=1
./miniruby basictest/test.rb
make test 
