class CreateAnalyses < ActiveRecord::Migration[6.0]
  def change
    create_table :analyses do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
