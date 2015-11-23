version = node['formatron_elasticsearch']['version']
checksum = node['formatron_elasticsearch']['checksum']
params = node['formatron_elasticsearch']['params']

cache = Chef::Config[:file_cache_path]
deb = File.join cache, 'elasticsearch.deb' 
deb_url = "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.0.0/elasticsearch-#{version}.deb"

remote_file deb do
  source deb_url
  checksum checksum
  notifies :install, 'dpkg_package[elasticsearch]', :immediately
end

dpkg_package 'elasticsearch' do
  source deb
  action :nothing
  notifies :restart, 'service[elasticsearch]', :delayed
end

template '/etc/elasticsearch/elasticsearch.yml' do
  group  'elasticsearch'
  variables(
    params: params || {}
  )
end

service 'elasticsearch' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
