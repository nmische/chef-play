# default.rb
#

package "zip"

execute "install-play" do
    user "root"
    cwd node['play']['install_dir']
    command <<-EOH
    unzip play-#{node[:play][:version]}.zip
    export PATH=$PATH:#{node['play']['install_dir']}/play-#{node['play']['version']}
    EOH
    action :nothing
end

remote_file "#{node[:play][:install_dir]}/play-#{node[:play][:version]}.zip" do
    source "http://download.playframework.org/releases/play-#{node[:play][:version]}.zip"
    mode "0644"
    notifies :run, "execute[install-play]", :immediately
    action :create_if_missing
end

