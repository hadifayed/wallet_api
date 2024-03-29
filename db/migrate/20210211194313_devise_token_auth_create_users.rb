class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.0]
  def change

    create_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "phone_number"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## User Info
      t.string :name, :null => false
      t.string :phone_number, :null => false
      t.integer :credit, :null => false
      t.integer :available_credit, :null => false
      t.integer :lock_version, :null => false, :default => 0

      ## Tokens
      t.text :tokens

      t.timestamps
    end

    add_index :users, :phone_number,                unique: true
  end
end
