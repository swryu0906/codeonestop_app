class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :fname
      t.string      :lname
      t.string      :email
      t.string      :url
      t.string      :git
      t.string      :password_digest

      t.timestamps
    end
  end
end
