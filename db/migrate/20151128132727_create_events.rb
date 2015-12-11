class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :place
      t.string :time

      t.timestamps null: false
    end
  end
end
