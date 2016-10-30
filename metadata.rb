name 'es-stack'

maintainer 'Said Sef'
maintainer_email 'saidsef@gmail.com.com'

license 'GPLv2'

description 'Installs/Configures es-stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.14'
ohai_version '~> 8'

source_url 'https://github.com/saidsef/es-stack'

%w{elasticsearch java apt yum nginx python}.each do |cookbook|
  depends cookbook
end

%w{debian ubuntu centos redhat fedora amazon mac_os_x}.each do |os|
  supports os
end
