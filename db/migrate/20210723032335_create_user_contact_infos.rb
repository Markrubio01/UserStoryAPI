class CreateUserContactInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :user_contact_infos do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :delivery_address
      t.string :billing_address
      t.timestamps
    end
  end
end
