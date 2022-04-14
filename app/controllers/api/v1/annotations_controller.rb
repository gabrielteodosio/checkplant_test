class Api::V1::AnnotationsController < ApplicationController

  def index
    @annotations = Annotation.all

    render json: @annotations
  end

  def show
    @annotation = Annotation.find_by(id: params[:id], user_id: current_user.id)

    if @annotation != nil
      render json: @annotation, status: :ok
    else
      render json: { message: "Error getting annotation" }, status: :not_found
    end
  end

  def create
    @annotation = Annotation.new(annotation_params)
    @annotation.user_id = current_user.id

    if @annotation.save
      render json: @annotation, status: :created
    else
      render json: { message: "Error creating an Annotation" }, status: :not_acceptable
    end
  end

  def destroy
    @annotation = Annotation.find_by(id: params[:id], user_id: current_user.id)

    if @annotation != nil
      @annotation.destroy

      render json: @annotation, status: :ok
    else
      render json: { message: "Error deleting an Annotation" }, status: :not_found
    end
  end

  private
  def annotation_params
    params.require(:annotation).permit(:description, :latitude, :longitude)
  end

end
