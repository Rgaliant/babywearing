class RemoveFullNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :full_name, :string
  end
end
