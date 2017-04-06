class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :url, null: false
      t.text :smmry, null: false
      t.string :title, null: false
      t.string :category, null: false
      t.string :age, null: false
      t.string :img_url, null: false
      t.timestamps
    end
  end
end
