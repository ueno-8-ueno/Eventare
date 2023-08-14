class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :introduction
      t.integer :user_id
      t.string :genre
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
