class User < ActiveRecord::Base
  enum status: [:contributor, :admin]

  authenticates_with_sorcery!
  validates :email, uniqueness: true, presence: true
  validates :password, length: {minimum: 3}, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

end