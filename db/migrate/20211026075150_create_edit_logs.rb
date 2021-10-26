class CreateEditLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :edit_logs do |t|
      t.string :title
      t.text :description
      t.string :field
      t.string :old_value
      t.string :new_value
      t.references :contact

      t.timestamps
    end
  end
end
