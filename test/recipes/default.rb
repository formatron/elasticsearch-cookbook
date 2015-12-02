node.default['java']['jdk_version'] = '8'
include_recipe 'java::default'

include_recipe 'formatron_elasticsearch::default'

formatron_elasticsearch_template 'test' do
  template(
    order: 0,
    template: "te*",
    settings: {
      index: {
        number_of_shards: "1"
      }
    },
    mappings: {
      type1: {
        _source: {
          enabled: false
        }
      }
    },
    aliases: {
    }
  )
end
