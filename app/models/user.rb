class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_paper_trail

  has_many :carts, inverse_of: :user, dependent: :destroy
  has_many :orders, inverse_of: :user, dependent: :destroy
end
