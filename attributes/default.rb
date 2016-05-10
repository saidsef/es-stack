# === VERSION
#

default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['elasticsearch']['version']           = '2.3.2'
default['elasticsearch']['install_type']      = :package

default['elasticsearch']['max_mem_percent']       = '80%'
default['elasticsearch']['limits']['hard']    = 'unlimited'
default['elasticsearch']['limits']['nofile']  = '500000'
default['elasticsearch']['limits']['memlock'] = 'unlimited'

default['elasticsearch']['index.number_of_shards']    = 1
default['elasticsearch']['index.number_of_replicas']  = 0
