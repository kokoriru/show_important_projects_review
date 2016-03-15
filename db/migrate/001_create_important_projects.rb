class CreateImportantProjects < ActiveRecord::Migration
  def change
    create_table :important_projects do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.boolean :is_important
    end
  end
end
