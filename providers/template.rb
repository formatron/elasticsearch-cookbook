def whyrun_supported?
  true
end

use_inline_resources

class JSONHTTP < Chef::HTTP
  self.use Chef::HTTP::JSONInput
  self.use Chef::HTTP::JSONOutput
end

def get_template(api, name)
  api.get(name)[name]
rescue
  nil
end

action :create do
  name = new_resource.name
  template = new_resource.template
  api = JSONHTTP.new "http://localhost:9200/_template"
  existing_template = get_template api, name
  unless existing_template.to_json.eql? template.to_json
    api.put name, template
    new_resource.updated_by_last_action true
  end
end
