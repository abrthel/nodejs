default['nodejs']['npm']['install_method'] = 'embedded'
default['nodejs']['npm']['version'] = 'latest'

default['nodejs']['npm']['user'] = 'root'
default['nodejs']['npm']['group'] = 'root'
default['nodejs']['npm']['prefix'] = "/home/#{node['nodejs']['npm']['user']}/npm-global"
