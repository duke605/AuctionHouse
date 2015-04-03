class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :credits, default: 0
      t.string :token
      t.date :expiry_date

      t.timestamps null: false
    end
  end
end
