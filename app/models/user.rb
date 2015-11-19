class User < ActiveRecord::Base;
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }, allow_blank: true
	before_save { self.email = email.downcase }
	# Este metodo consigue un password seguro y algunas otras cosas como:
	# 1.- Genera un hash encriptado por medio de "bcrypt"
	# 2.- Genera dos variables virturtuales "password" y "password_confirmation"
	# 3.- Una manera de autentificar a los usuarios cuando enten a la aplicacion
	# Entre otras cosas...
	has_secure_password
	## Metodo definido para el test
	## Returns the hash digest of the given string.

	has_many :products
	
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

end

class God < User; end
class Admin < User; end
class Seller < User; end
class Customer < User; end

