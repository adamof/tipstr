class ChangeOutcomeType < ActiveRecord::Migration
  def change
    remove_column :bets, :outcome
    add_column :bets, :outcome, :string, :default => 'pending'
  end
end
