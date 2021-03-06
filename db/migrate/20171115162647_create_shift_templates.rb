class CreateShiftTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_templates do |t|
      t.column :floor, :string
      t.column :details, :string

      t.integer :hours
      t.string :day
      t.string :time

      t.references :shift_detail, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
