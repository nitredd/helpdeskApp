class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :summary
      t.text :body
      t.string :status
      t.string :reporter
      t.string :assigned_to

      t.timestamps
    end
  end
end
