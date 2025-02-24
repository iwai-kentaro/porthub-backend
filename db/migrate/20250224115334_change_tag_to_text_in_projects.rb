class ChangeTagToTextInProjects < ActiveRecord::Migration[8.0]
  def change
    change_column :projects, :tag, :text

  end
end
