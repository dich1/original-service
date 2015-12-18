class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  paginates_per 5
end
