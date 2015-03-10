class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  ## Acciones regulares REST ##
	def show
  	@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
  	@user = User.new(user_params)   
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the App!"
  		redirect_to user_url(@user) # Modo compacto redirect_to @user
  	else
  		render 'new'
  	end
	end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], :per_page => 10 )
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

	private # Apartir de esta line todos los metodos son privados.

  	# "Parametros fuertes" Solo permite recibir, de una peticion,
  	# los parametro permitidos aqui.
  	def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # metodo que confirma que haya un usuario logeado, es utilizado 
    # por los filtros "before".
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    # confirma el usuario correcto
    def correct_user
      @user = User.find(params[:id])
      redirect_to(user_path(current_user)) unless current_user?(@user)
    end
    # confirma a un usuario de tipo admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
