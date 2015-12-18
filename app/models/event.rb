class Event < ActiveRecord::Base
  has_many :users, class_name: "User", 
                   foreign_key: "event_id", 
                   dependent: :destroy
  has_many :join_relationships, class_name: "Relationship",
                                foreign_key: "event_id", 
                                dependent: :destroy
  has_many :join_users , through: :join_relationships, source: :user
  has_many :microposts
  
  # イベントに参加する
  def join(other_user)
    join_relationships.create(join_id: other_user.id)
  end

  # 参加しているイベントから抜ける
  def unjoin(other_user)
    join_relationships.find_by(join_id: other_user.id).destroy
  end

  # あるイベントに参加しているかどうか？
  def join?(other_user)
    join_users.include?(other_user)
  end

  def feed_items
    Micropost.where(user_id: joining_user_ids + [self.id])
  end
end
