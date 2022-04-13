class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      token = user.generate_jwt
      render json: { user: user, token: token }, status: :ok
    else
      render json: { message: "Invalid credentials" }, status: :unprocessable_entity
    end
  end

  private
  def respond_with(resource, _opts = {})
    render json: { message: "Logged in successfully" }, status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "Logged out successfully" }, status: :ok
  end

  def log_out_failure
    render json: { message: "Something went wrong while logging you out"}, status: :unauthorized
  end
end