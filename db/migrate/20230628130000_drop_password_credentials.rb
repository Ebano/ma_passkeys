class DropPasswordCredentials < ActiveRecord::Migration[6.0]
  def change
    drop_table :password_credentials
  end
end
