class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :counter, default: 0
      t.string :ip_address

      t.timestamps
    end
  end
end
