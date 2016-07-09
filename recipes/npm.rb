#
# Author:: Marius Ducea (marius@promethost.com)
# Cookbook Name:: nodejs
# Recipe:: npm
#
# Copyright 2010-2012, Promet Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['nodejs']['npm']['install_method']
when 'embedded'
  include_recipe 'nodejs::install'
when 'source'
  include_recipe 'nodejs::npm_from_source'
else
  Chef::Log.error('No install method found for npm')
end

execute 'Fix NPM permissions' do
  environment ({ 'HOME' => "/home/#{node['nodejs']['npm']['user']}/",
   'USER' => node['nodejs']['npm']['user'] })
  user node['nodejs']['npm']['user']
  group node['nodejs']['npm']['group']
  action :run
  command <<-EOH
    mkdir #{node['nodejs']['npm']['prefix']}
    npm config set prefix #{node['nodejs']['npm']['prefix']}
    echo "
    if [ -d "$HOME/#{node['nodejs']['npm']['prefix']}/bin" ] ; then
      PATH=$PATH:$HOME/#{node['nodejs']['npm']['prefix']}/bin
    fi
    " >> ~/.bashrc
  EOH
  not_if { ::File.directory?(node['nodejs']['npm']['prefix']) }
end
