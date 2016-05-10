name 'es-stack'
maintainer 'Said Sef'
maintainer_email 'saidsef@gmail.com.com'
license 'GPLv2'
description 'Installs/Configures es-stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'

%w{elasticsearch java apt yum nginx python}.each do |cookbook|
  depends cookbook
end

%w{ubuntu centos redhat fedora}.each do |os|
  supports os
end