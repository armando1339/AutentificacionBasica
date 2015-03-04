class UsersController < ApplicationController
	
	def show
    	@user = User.find(params[:id])
  	end

  	def new
  		@user = User.new
  	end

  	def create
    	@user = User.new(user_params)   
    	if @user.save
    		flash[:success] = "Welcome to the App!"
      		redirect_to user_url(@user)
    	else
      		render 'new'
    	end
  	end

	private # Apartir de esta line todos los metodos son privados.

	  	# "Parametros fuertes" Solo permite recibir, de una peticion,
	  	# los parametro permitidos aqui.
	  	def user_params
	      params.require(:user).permit(:name, :email, :password, :password_confirmation)
	    end


end
