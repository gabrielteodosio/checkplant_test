class User < ApplicationRecord

  has_many :annotations
  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  def generate_jwt
    JWT.encode({id: id, exp: 30.days.from_now.to_i}, Rails.application.credentials.devise[:jwt_secret_key])
  end

  def valid_password?(password)
    password == self.encrypted_password
  end
end
