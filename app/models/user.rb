class User < ApplicationRecord
  validates :email,{uniqueness:true,presence:true}#emailは固有
  validates :name,{presence:true}
  validates :password,{presence:true}

  def posts
    return Post.where(user_id: self.id)
  end
end
