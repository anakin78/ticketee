class User < ActiveRecord::Base
	has_secure_password
	has_many :permissions
	validates :email, presence: true

	devise :database_authenticatable, :registerable, :confirmable,
	:recoverable, :rememberable, :trackable, :validatable,
	:token_authenticatable

	before_save :ensure_authentication_token


	def to_s
		"#{email} (#{admin? ? "Admin" : "User"})"
	end
end
