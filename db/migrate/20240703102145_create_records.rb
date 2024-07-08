class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :label
      t.belongs_to :survey
      t.timestamps
    end
  end
end
