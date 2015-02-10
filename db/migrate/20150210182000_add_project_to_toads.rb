class AddProjectToToads < ActiveRecord::Migration
  def change
    add_reference :toads, :project, index: true
  end
end
