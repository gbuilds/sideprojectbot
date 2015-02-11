class Project < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  
  belongs_to :user
  has_many :toads, dependent: :destroy
end
