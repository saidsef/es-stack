#
# Cookbook Name:: es-stack
# Recipe:: default
#
# Copyright (c) 2016 Said Sef, All Rights Reserved.

include_recipe 'java::default'
include_recipe 'python::default'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'
elasticsearch_configure 'elasticsearch'
elasticsearch_service 'elasticsearch'

%W{mobz/elasticsearch-head}.each do |package|
  elasticsearch_plugin "#{package}" do
    action :install
  end
end

elasticsearch_configure "#{node['elasticsearch']['node.name']}" do
  # if you override one of these, you probably want to override all

  logging({:"action" => 'INFO'})

  allocated_memory "#{((node['elasticsearch']['max_mem_percent'].to_f / 100.0 ) * node['memory']['total'].to_i / 1024).ceil}m"
  thread_stack_size '512k'

  env_options node['elasticsearch']['env_options']
  gc_settings <<-CONFIG
                -XX:+UseParNewGC
                -XX:+UseConcMarkSweepGC
                -XX:CMSInitiatingOccupancyFraction=75
                -XX:+UseCMSInitiatingOccupancyOnly
                -XX:+HeapDumpOnOutOfMemoryError
                -XX:+PrintGCDetails
              CONFIG

  configuration ({
    'node.name' => node['fqdn'],
    'cluster.name' => node['elasticsearch']['node.name'],
    'node.master' => true,
    'node.data' => true,
    'path.data' => node['elasticsearch']['path.data'],
    'path.logs' => node['elasticsearch']['path.logs'],
    'refresh_interval' => '60s',
    'indices.store.throttle.type' => 'none',
    'indices.recovery.max_bytes_per_sec' => '200mb',
    'indices.recovery.concurrent_streams' => 3,
    'bootstrap.mlockall' => true

  })

  action :manage
end

%W{elasticsearch elasticsearch-curator flask}.each do |package|
  python_pip package do
    action :install
  end
end
