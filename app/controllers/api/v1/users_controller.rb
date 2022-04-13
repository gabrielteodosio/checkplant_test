class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    begin
      @user = current_user

      render json: @user, status: :ok
    rescue ActiveRecord::RecordNotFound => exception
      render json: { "message": "Error getting profile" }, status: :not_found
    end
  end

  private
  def current_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split().last, Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    user = User.find(user_id.to_s)
  end

end