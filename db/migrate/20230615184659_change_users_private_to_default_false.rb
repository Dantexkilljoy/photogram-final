class ChangeUsersPrivateToDefaultFalse < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :private, false
  end
end
