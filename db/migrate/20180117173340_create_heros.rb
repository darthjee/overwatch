class CreateHeros < ActiveRecord::Migration[5.1]
  def change
    create_table :heros do |t|
      t.string :name
      t.string :real_name
      t.integer :health
      t.integer :armor
      t.integer :shield

      t.timestamps
    end
  end
end
