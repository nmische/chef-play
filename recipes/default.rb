# default.rb
#

package "zip"

execute "install-play" do
    user node['play']['user']
    cwd node['play']['install_dir']
    command <<-EOH
    unzip play-#{node['play']['version']}.zip
    export PATH=$PATH:#{node['play']['install_dir']}/play-#{node['play']['version']}
    EOH
    action :nothing
end

remote_file "#{node['play']['install_dir']}/play-#{node['play']['version']}.zip" do
    source "http://downloads.typesafe.com/play/2.2.0/play-#{node['play']['version']}.zip"
    mode "0644"
    notifies :run, "execute[install-play]", :immediately
    action :create_if_missing
end

template "/etc/profile.d/play.sh" do
    source "play.erb"
    owner "root"
    group "root"
    mode 00644
    only_if { Dir.exists?("/etc/profile.d") }
end

