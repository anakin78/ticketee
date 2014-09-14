class Admin::StatesController < Admin::BaseController

	def new
		@state = State.new
	end

	def index
		@states = State.all
	end

	def create
	@state = State.new(states_param)
		if @state.save
			flash[:notice] = "State has been created."
			redirect_to admin_states_path
		else
			flash[:alert] = "State has not been created."
			render :action => "new"
		end
	end

	private

	def states_param
		params.require(:state).permit(:name)
	end
end
