#
# Licensed Materials - Property of IBM
#
# 2013-IBM
#
# (C) Copyright IBM Corp. 2013    All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with
# IBM Corp.
#
include_recipe 'resolver'

execute "git user" do
    command "printf '[user]\n    name = Dean Okamura\n    email = dokamura@us.ibm.com\n' >> /home/vagrant/.gitconfig"
    creates "/home/vagrant/.gitconfig"
end

directory "/home/vagrant/temp" do
    owner "vagrant"
    group "vagrant"
    mode 0775
    action :create
end

link "/home/vagrant/cmvc" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/cmvc"
end

link "/home/vagrant/etc" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/etc"
end

link "/home/vagrant/tms630fp2" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/tms630fp2"
end

yum_package "git" do
  action :install
end

yum_package "mksh" do
  action :install
end

# Quick-N-Dirty ITM
directory "/opt/IBM" do
  owner "root"
  mode "0755"
  action :create
end

directory "/opt/IBM/ITM" do
  owner "vagrant"
  mode "0775"
  action :create
end

remote_file "/tmp/centos-64-x64-itm-lite.tar.gz" do
  source "https://dl.dropboxusercontent.com/u/20692025/centos-64-x64-itm-lite.tar.gz"
  action :create_if_missing
  mode "0744"
  owner "vagrant"
  group "vagrant"
end

execute "extract Quick-N-Dirty ITM" do
  command "cd /opt/IBM; tar -zxvf /tmp/centos-64-x64-itm-lite.tar.gz"
  user "vagrant"
  not_if { ::File.exists?("/opt/IBM/ITM/bin")}
end
