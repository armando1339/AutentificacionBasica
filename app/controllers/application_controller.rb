class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProductsHelper
  include ShoppingBagsHelper

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
      # redirect_to(root_url) => Opcion 
      redirect_to(user_path(current_user)) unless current_user.admin?
    end


    

end
