class Toad < ActiveRecord::Base
  belongs_to :project
  validates :description, presence: true
  
  default_scope -> { order(created_at: :desc) }
  
end
