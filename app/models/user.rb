class User < ActiveRecord::Base
  has_secure_password
  has_many :memberships
  has_many :orgs
  has_many :org_memberships, through: :memberships, source: :org

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: {minimum: 8}, on: :create
  before_validation :email_lowercase

  private
    def email_lowercase
      self.email = email.downcase
    end
end
