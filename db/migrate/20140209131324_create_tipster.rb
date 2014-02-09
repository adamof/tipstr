class CreateTipster < ActiveRecord::Migration
  def change
    create_table :tipsters do |t|
      t.string :name, null: false
      t.string :facebook_link
      t.string :referral_link

      t.timestamps
    end
  end
end
