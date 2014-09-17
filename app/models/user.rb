class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	has_many :permissions
	validates :email, presence: true

	devise :database_authenticatable, :registerable, :confirmable,
	:recoverable, :rememberable, :trackable, :validatable
		
	before_save :ensure_authentication_token

	def ensure_authentication_token
	    if authentication_token.blank?
	      self.authentication_token = generate_authentication_token
	    end
  	end

 	def to_s
		"#{email} (#{admin? ? "Admin" : "User"})"
	end
	
  private
    
	def generate_authentication_token
	    loop do
	      token = Devise.friendly_token
	      break token unless User.where(authentication_token: token).first
	    end
	end

	
end
