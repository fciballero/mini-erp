class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  acts_as_tenant(:organization)

  belongs_to :organization
end
