class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, unll:false
      t.integer :author_id, unll:false
      t.integer :post_id, unll:false
      t.integer :comment_id, unll:false 

      t.timestamps
    end
  end
end
