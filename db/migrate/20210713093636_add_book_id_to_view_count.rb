class AddBookIdToViewCount < ActiveRecord::Migration[5.2]
  def change
    add_column :view_counts, :book_id, :integer
  end
end
