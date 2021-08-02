class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followed_users, through: :followers, source: :followeds
  has_many :follower_users, through: :followeds, source: :followers
  
  attachment :profile_image

  validates :name, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
