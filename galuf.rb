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

workdir = File.join(Dir.tmpdir, package)
FileUtils.rm_rf(workdir)
Dir.mkdir(workdir)
Dir.chdir(workdir)

system('git init')
system('git config core.sparsecheckout true')
system('git remote add origin https://github.com/fd00/yacp.git')
system("echo #{package} > .git/info/sparse-checkout")
system("git pull --depth=1 origin master")

Dir.chdir(package)

cygport = Dir.glob('*.cygport')
unless cygport.length == 1
  p "*.cygport file must be unique."
  exit 1
end
cygport = cygport[0]
version_release = cygport.gsub('.cygport', '').gsub("#{package}-", '')
system("rename #{version_release} #{new_version}-1bl1 *")
system("cygport *.cygport all")
