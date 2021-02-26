#!/usr/bin/env ruby

require 'fileutils'
require 'tmpdir'

package = ENV['PACKAGE']
if package.nil?
  p "ENV['PACKAGE'] must be set."
  exit 1
end

new_version = ENV['NEW_VERSION']
if new_version.nil?
  p "ENV['NEW_VERSION'] must be set."
  exit 1
end

branch = ENV['BRANCH']
if branch.nil?
  branch = 'master'
end

Dir.mkdir('galuf')
Dir.chdir('galuf')

system('git init', exception: true)
system('git config core.sparsecheckout true', exception: true)
system('git remote add origin https://github.com/fd00/yacp.git', exception: true)
system("echo #{package} > .git/info/sparse-checkout", exception: true)
system("git pull --depth=1 origin #{branch}", exception: true)

Dir.chdir(package)

File.open(File.expand_path(File.join(Dir.home, '.cygportrc')), 'w') do |rc|
  rc.puts('RESTRICT=debuginfo')
end

cygport = Dir.glob('*.cygport')
unless cygport.length == 1
  p '*.cygport file must be unique.'
  exit 1
end
cygport = cygport[0]
version_release = cygport.gsub('.cygport', '').gsub("#{package}-", '')
system("rename #{version_release} #{new_version}-1bl1 *", exception: true) unless version_release == "#{new_version}-1bl1"
system('cygport *.cygport fetch prep', exception: true)
system("cp README #{package}-#{new_version}-1bl1.x86_64/CYGWIN-PATCHES/", exception: true)
system('cygport *.cygport compile install package', exception: true)

Dir.chdir('..')
system("tar cfvz #{package}.tar.gz #{package}")
