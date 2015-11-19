module SessionsHelper
    # log_in crea una sesion colocando un coockie temporal en el navegador,
    # colocando el id del usuario en esa sesion tempotal
    def log_in(user)
      session[:user_id] = user.id
    end
    # current_user encuentra al usuario actual de la sesion,
    # si la variable esta vacia busca en la base de datos. 
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    # retorna true si hay un asuario logeado
    def logged_in?
      !current_user.nil?
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
    # Devuelve true si el usuario dado es el usuario actual.
    def current_user?(user)
      user == current_user
    end

    def admin_user?
      current_user.admin?
    end
end
