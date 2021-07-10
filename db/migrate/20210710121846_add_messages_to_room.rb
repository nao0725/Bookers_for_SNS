class AddMessagesToRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :messages, :text
  end
end
