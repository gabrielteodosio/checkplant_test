class CreateAnnotations < ActiveRecord::Migration[7.0]
  def change
    create_table :annotations do |t|
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
