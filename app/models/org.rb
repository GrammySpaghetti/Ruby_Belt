class Org < ActiveRecord::Base
  belongs_to :user
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, length: {minimum: 6}
  validates :desc, presence: true, length: {minimum: 11}
end
