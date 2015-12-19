class AddEventToMicroposts < ActiveRecord::Migration
  def change
    add_reference :microposts, :event, index: true, foreign_key: true
  end
end
