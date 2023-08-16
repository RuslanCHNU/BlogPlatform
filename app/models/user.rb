class User < ApplicationRecord
  has_many :blog_posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
