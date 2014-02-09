class CreateBet < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.text :text
      t.string :game
      t.boolean :outcome
      t.belongs_to :tipster

      t.timestamps
    end
  end
end
