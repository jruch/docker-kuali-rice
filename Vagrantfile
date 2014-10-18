# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
  config.vm.define "mysql" do |mysql|
    mysql.vm.provider "docker" do |d|
      d.image = "mztaylor/docker-mysql"
      d.name = "mysqlrice"
      d.create_args = ["-e", "MYSQL_ROOT_PASSWORD=root"]
      d.ports = ['3306:3306']
    end
  end

  config.vm.define "web" do |web|
    web.vm.provider "docker" do |d|
      d.image = "mztaylor/docker-kuali-rice"
      d.name = "ricedemo"
      d.link('mysqlrice:mysql')
      d.ports = ['8080:8080']
    end
  end
end