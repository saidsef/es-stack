# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['NOKOGIRI_USE_SYSTEM_LIBRARIES'] = 'true'
%w{ vagrant-berkshelf vagrant-hostmanager vagrant-salt vagrant-vbguest}.each do |plugin|
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
  config.vm.hostname = HOST_MACHINE

  config.vm.define 'es' do |es|
    es.vm.box = box_name
    es.vm.box_url = box_url
    es.vm.network :private_network, ip: ELASTICSEARCH, auto_config: false
    #es.vm.provision 'shell', inline: "ifconfig eth1 10.0.100.30"
    es.vm.hostname = 'es.local'

    es.vm.network "forwarded_port", guest: 9200, host: 9200
    es.vm.network "forwarded_port", guest: 9300, host: 9300

    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = 1024
    end

    es.vm.provision :chef_solo do |chef|
      chef.add_recipe 'hostname::default'
      chef.add_recipe 'es-stack::default'
      chef.json = {
        "name" => "elk-stack"
      }
    end
  end
end
