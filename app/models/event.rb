class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users, through: :attendees
  has_many :microposts
  
  # イベントに参加する
  def join(other_user)
    user_attendees.create(join_id: other_user.id)
  end

  # 参加しているイベントから抜ける
  def unjoin(other_user)
    user_attendees.find_by(join_id: other_user.id).destroy
  end

  # あるイベントに参加しているかどうか？
  def join?(other_user)
    attendee_users.include?(other_user)
  end

  def feed_items
    Micropost.where(user_id: attendee_user_ids + [self.id])
  end
end