# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  password_digest :string           not null
#  session_token   :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true 
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :reset_session_token!
  
  attr_reader :password
  
  def reset_session_token! 
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def password=(password)
    @password = password 
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    if @user
      @user.is_password?(password) ? @user : nil
    else
      nil 
    end
  end
  
end
