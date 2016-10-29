# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.0"

require 'fileutils'

ENV['NOKOGIRI_USE_SYSTEM_LIBRARIES'] = 'true'
%w{ vagrant-berkshelf vagrant-hostmanager vagrant-vbguest vagrant-share}.each do |plugin|
  # Will install dependent plugin
  unless Vagrant.has_plugin?(plugin)
    puts '*********************************'
    puts "Installing #{plugin} plugin"
    `vagrant plugin install #{plugin}`
  end
end

VAGRANTFILE_API_VERSION = '2'

box_name = 'ubuntu/xenial64'
box_url = 'https://atlas.hashicorp.com/ubuntu/boxes/xenial64'

HOST_MACHINE  = '10.0.100.1'
KIBANA        = '10.0.100.10' # TODO
LOGSTASH      = '10.0.100.20' # TODO
ELASTICSEARCH = '10.0.100.30'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = './Berksfile'

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.hostname = HOST_MACHINE

  # hostmanager provisioner
  config.vm.provision :hostmanager

  config.vm.define 'es' do |es|
    es.vm.box = box_name
    es.vm.box_url = box_url
    es.vm.network :private_network, ip: ELASTICSEARCH, auto_config: false
    es.hostmanager.aliases = %w(es.local)

    es.vm.network "forwarded_port", guest: 9200, host: 9200
    es.vm.network "forwarded_port", guest: 9300, host: 9300

    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = 1024
    end

    es.vm.provision :chef_zero do |chef|
      chef.nodes_path = "./"
      chef.add_recipe 'es-stack::default'
      chef.json = {"name" => "es-stack"}
    end
  end
end
