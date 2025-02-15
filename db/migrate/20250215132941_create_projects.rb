class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :tag
      t.string :image
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.string :portfolio_url

      t.timestamps
    end
  end
end
