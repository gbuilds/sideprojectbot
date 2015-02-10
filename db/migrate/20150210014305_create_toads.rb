class CreateToads < ActiveRecord::Migration
  def change
    create_table :toads do |t|
      t.string :description
      t.boolean :complete, default: false

      t.timestamps null: false
    end
  end
end
