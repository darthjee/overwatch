class CreateAbilities < ActiveRecord::Migration[5.1]
  def change
    create_table :abilities do |t|
      t.string :name
      t.string :description
      t.boolean :is_ultimate

      t.timestamps
    end
  end
end
