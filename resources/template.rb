actions :create
default_action :create

attribute :name, name_attribute: true, kind_of: String, required: true
attribute :template, kind_of: Hash, required: true
