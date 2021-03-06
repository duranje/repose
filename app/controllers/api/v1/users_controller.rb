class Api::V1::UsersController < Api::V1::BaseController 
	def show
		user = User.find(params[:id])

		render(json: Api::V1::UserSerializer.new(user).to_json)
	end

	def create
		user = User.create(user_params)
		puts params
		if user && user.id
			render(json: Api::V1::UserSerializer.new(user).to_json)
		else
			status 400
		end
	end

	def user_params
	   params.require(:user).permit(:email, :password)
	end
end