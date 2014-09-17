class UsersController < ApplicationController
  	before_action :set_user, only: [:show, :edit, :update, :destroy]
  	before_filter :authenticate_user!

  	def new
		@user = User.new
  	end
=begin
  	def create
		@user = User.new(user_params)
		p user_params
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "You have signed up successfully."
			redirect_to projects_path
		else
			render :new
		end
	end
=end
  	def show
  	end

  	def edit
  	end

  	def update
  		if @user.update(user_params)
			flash[:notice] = "Profile has been updated."
			redirect_to @user
		else
			flash[:alert] = "Profile has not been updated."
			render "edit"
		end
  	end

  	private
  	
  	def set_user
  		@user = User.find(params[:id])
  	end

=begin
	def user_params
		params.require(:user).permit(:name,:email,:password, :password_confirmation)
	end
=end

end
