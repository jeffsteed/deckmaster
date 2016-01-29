class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.string :deck, array: true, default: []
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
