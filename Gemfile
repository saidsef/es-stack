source 'https://rubygems.org'

gem 'net-ssh', '~> 3.2.0'
gem 'test-kitchen'
gem 'kitchen-docker'

group :integration do
  # not a strict dependency, but necessary for TK testing
  cookbook 'java'
  cookbook 'curl'
end
