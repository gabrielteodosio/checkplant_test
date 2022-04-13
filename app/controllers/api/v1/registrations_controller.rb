class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)

    if user.save
      token = user.generate_jwt
      render json: { "user": user, "token": token }, status: :created
    else
      render json: { "message": "Error signing up User" }, status: :unprocessable_entity
    end
  end

  private
  def sign_up_params
    params.permit(:email, :encrypted_password)
  end

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end
end