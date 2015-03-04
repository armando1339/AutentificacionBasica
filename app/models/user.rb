class User < ActiveRecord::Base
	# Esta linea convierte el atributo email en minusculas antes de guardarlo.
	before_save { self.email = email.downcase }
	# validacion que dice que el atributo nombre no puede quedar en blanco 
	# y que no puede tener mas de 50 digito
	validates :name, presence: true, length: { maximum: 50 }
	# validacion que dice que  el atributo email no puede quedar en blanco,
	# que no puede tener mas de 255 digitos, que tiene que cumplir especificaciones de formato acorde a un email
	# y que tiene que ser unico en la base de datos.
	validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
	# Este metodo consigue un password seguro y algunas otras cosas como:
	# 1.- Genera un hash encriptado por medio de "bcrypt"
	# 2.- Genera dos variables virturtuales "password" y "password_confirmation"
	# 3.- Una manera de autentificar a los usuarios cuando enten a la aplicacion
	# Entre otras cosas...
	has_secure_password
	# Validacion para que el pasword sea mayor a 6 digitos
	validates :password, length: { minimum: 6 }

end
