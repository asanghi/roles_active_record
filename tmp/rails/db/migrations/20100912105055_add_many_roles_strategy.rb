class AddManyRolesStrategy < ActiveRecord::Migration
  class << self

    def up          
      create_roles
      create_user_roles
    end

    def down      
      drop_roles
      drop_user_roles
    end

    protected

    def create_user_roles
      create_table :user_roles do |t|
        t.integer :user_id
        t.integer :role_id
        t.timestamps
      end
    end

    def drop_user_roles
      drop_table :user_roles
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
