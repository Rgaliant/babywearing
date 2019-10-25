class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, nullable: false
    add_column :users, :last_name, :string, nullable: false
  end
end
