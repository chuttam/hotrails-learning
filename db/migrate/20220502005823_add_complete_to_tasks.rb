class AddCompleteToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :complete, :boolean
  end
end
