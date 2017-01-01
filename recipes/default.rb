#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2016, The Authors, All Rights Reserved.
# execute "sudo yum install java-1.7.0-openjdk-devel"
package 'java-1.7.0-openjdk-dlevel'

#execute 'sudo groupadd tomcat'
group 'tomcat' 

#execute 'sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat'
user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
  home '/opt/tomcat'
 end

#execute 'wget http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz'
remote_file 'apache-tomcat-8.0.32.tar.gz'
  source 'http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz'

directory '/opt/tomcat'do
#action :create
end

# TODO:NOT DESIRED STATE
execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

# TODO:NOT DESIRED STATE
execute 'chgrp -R tomcat /opt/tomcat/conf'

directory '/opt/tomcat/conf' do
mode '0070'
end

# TODO:NOT DESIRED STATE
execute 'chmod g+r /opt/tomcat/conf/*'

# TODO:NOT DESIRED STATE
execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

template 'etc/systemd/system/tomcat.service'
  source 'tomcat.service.erb'
  end

#TODO NOT DESIRED STATE
execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end




