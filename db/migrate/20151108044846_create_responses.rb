class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string      :title
      t.text        :content
      t.references  :post, index: true, foreign_key: true
      t.references  :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
