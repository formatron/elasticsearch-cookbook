version = node['formatron_elasticsearch']['version']

params = node['formatron_elasticsearch']['params']

apt_repository 'elasticsearch-2.x' do
  uri 'https://packages.elastic.co/elasticsearch/2.x/debian'
  components ['main']
  distribution 'stable'
  key 'D88E42B4'
  keyserver 'pgp.mit.edu'
  deb_src false
end

package 'elasticsearch' do
  version version
end

template '/etc/elasticsearch/elasticsearch.yml' do
  group  'elasticsearch'
  variables(
    params: params || {}
  )
  notifies :restart, 'service[elasticsearch]', :delayed
end

service 'elasticsearch' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
