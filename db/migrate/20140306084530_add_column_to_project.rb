class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :website, :string
  end
end
