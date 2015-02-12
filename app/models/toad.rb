class Toad < ActiveRecord::Base
  belongs_to :project
  validates :description, presence: true
  
  default_scope -> { order(created_at: :desc) }
  
#   def created_at_pretty
#     self.created_at.strftime("%b %d, %Y")
#   end
end
