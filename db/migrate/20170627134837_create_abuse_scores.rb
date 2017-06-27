class CreateAbuseScores < ActiveRecord::Migration
  def change
    create_table :abuse_scores do |t|
      t.string :ip
      t.integer :points
      t.string :reason

      t.timestamps null: false

      t.index :ip
      t.index :created_at
      t.index %i[ip created_at]
    end
  end
end
