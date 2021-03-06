class AddOneRoleStrategy < ActiveRecord::Migration
  class << self

    def up          
      create_roles
      add_user_role
    end

    def down      
      drop_roles
      remove_user_role
    end

    protected

    def add_user_role
      change_table :users do |t|
        t.integer :role_id
      end
    end

    def remove_user_role
      change_table :users do |t|
        t.remove :role_id
      end
    end


    def create_roles
      create_table :roles do |t|
        t.string  :name
        t.timestamps
      end
    end

    def drop_roles
      drop_table :roles
    end
  end
end
