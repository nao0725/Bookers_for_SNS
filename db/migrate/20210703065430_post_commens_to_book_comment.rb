class PostCommensToBookComment < ActiveRecord::Migration[5.2]
    def change
    create_table :book_comments do |t|
      t.text :comment
      t.integer :user_id

      t.timestamps
      end
    end
end
