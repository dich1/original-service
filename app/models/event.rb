class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users, through: :attendees
  has_many :microposts
  
  # イベントに参加する
  def participant(current_user)
    attendees.find_or_create_by(user_id:current_user.id)
  end

  # 参加しているイベントから抜ける
  def nonparticipant(current_user)
    attendees.find_by(user_id:current_user.id).destroy
  end

  # あるイベントに参加しているかどうか？
  def participant?(current_event)
    attendee_events.include?(current_event)
  end

  def feed_items
    Micropost.where(user_id: attendee_user_ids + [current_user.id])
  end
end