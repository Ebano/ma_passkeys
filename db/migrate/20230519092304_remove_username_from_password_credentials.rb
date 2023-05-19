class RemoveUsernameFromPasswordCredentials < ActiveRecord::Migration[6.0]
  def change
    remove_column :password_credentials, :username, :string
  end
end
