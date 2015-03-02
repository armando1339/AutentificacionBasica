class User < ActiveRecord::Base
	# esta linea convierte el atributo email en minusculas antes de guardarlo.
	before_save { self.email = email.downcase }
	# validacion para el atributo nombre
	validates :name, presence: true, length: { maximum: 50 }
	# validacion para el atributo email
	validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }

end
