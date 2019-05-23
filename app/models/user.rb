class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true, length: {maximum: Settings.name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {maximum: Settings.email_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.password_min_length}
  has_secure_password
end
