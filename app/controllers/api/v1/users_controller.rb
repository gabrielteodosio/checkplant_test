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

end