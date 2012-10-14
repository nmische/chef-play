# default.rb
#

remote_file "/usr/src/play-#{node[:play][:version]}.tar.gz" do
    source node[:play][:source_uri]
    mode 0644
end

bash "install play" do
    user "root"
    cwd "/usr/src/"
    code <<-EOH
    tar xzvf play-#{node[:play][:version]}.tar.gz
    export PATH=$PATH:/usr/src/play-#{node[:play][:version]}
    EOH
end

