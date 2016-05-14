#
# Cookbook Name:: es-stack
# Attribute:: default
#
# Copyright (c) 2016 Said Sef, All Rights Reserved.
#
# === VERSION
#

default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['elasticsearch']['version']           = '2.3.2'
default['elasticsearch']['install_type']      = :package

default['elasticsearch']['node.name']         = if !node['fqdn'].nil? and !node['fqdn'].empty? 
                                                  node['fqdn']
                                                else
                                                  node['ipaddress']
                                                end

default['elasticsearch']['cluster.name']      = 'elasticsearch'

default['elasticsearch']['env_options']       = ''

default['elasticsearch']['path.data']         = ['/usr/share/elasticsearch']
default['elasticsearch']['path.logs']         = ['/var/log/elasticsearch']

default['elasticsearch']['max_mem_percent']   = '85%'
default['elasticsearch']['limits']['hard']    = 'unlimited'
default['elasticsearch']['limits']['nofile']  = '500000'
default['elasticsearch']['limits']['memlock'] = 'unlimited'

default['elasticsearch']['cloud.node.auto_attributes'] = true
default['elasticsearch']['index.number_of_shards']     = 1
default['elasticsearch']['index.number_of_replicas']   = 0

default['elasticsearch']['network.bind_host']          = "0.0.0.0"
default['elasticsearch']['network.publish_host']       = "_non_loopback:ipv4_"
