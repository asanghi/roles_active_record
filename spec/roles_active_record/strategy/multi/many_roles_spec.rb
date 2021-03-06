require 'spec_helper'
use_roles_strategy :many_roles

def api_migrate
  migrate('many_roles')
end

def api_fixture
  load 'fixtures/many_roles_setup.rb'
end

def api_name
  :many_roles
end

load 'roles_active_record/strategy/api_examples.rb'




