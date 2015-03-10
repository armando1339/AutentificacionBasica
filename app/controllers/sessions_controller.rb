class SessionsController < ApplicationController
  
  def new
  end

  def create
  	# Esta linea busca en la base de datos al usuario por medio del email
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      	log_in user
      	redirect_to user_url(user) # Modo compacto redirect_to user
    else
      	flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      	render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
