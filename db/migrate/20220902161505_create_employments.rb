class CreateEmployments < ActiveRecord::Migration[7.0]
  def change
    create_table :employments do |t|
      t.string :employer, null: false
      t.string :start_date, null: false
      t.string :end_date, null: false
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
