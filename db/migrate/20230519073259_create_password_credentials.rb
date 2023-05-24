class CreatePasswordCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :password_credentials do |t|
      t.references :user, null: false, foreign_key: true
      t.string :username
      t.string :encrypted_password

      t.timestamps
    end
  end
end
