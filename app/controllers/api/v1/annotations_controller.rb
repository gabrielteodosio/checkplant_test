class Api::V1::AnnotationsController < ApplicationController

  def index
    @annotations = Annotation.all

    render json: @annotations
  end

  def show
    begin
      @annotation = Annotation.find(params[:id])

      render json: @annotation, status: :ok
    rescue ActiveRecord::RecordNotFound => exception
      render json: { "message": "Error getting annotation" }, status: :not_found
    end
  end

  def create
    @annotation = Annotation.new(annotation_params)

    if @annotation.save
      render json: @annotation, status: :created
    else
      render json: { "message": "Error creating an Annotation" }
    end
  end

  def destroy
    begin
      @annotation = Annotation.find(params[:id])

      @annotation.destroy

      render json: @annotation, status: :ok
    rescue ActiveRecord::RecordNotFound => exception
      render json: { "message": "Error deleting an Annotation" }, status: :not_found
    end
  end

  private
  def annotation_params
    params.require(:annotation).permit(:user_id, :description, :latitude, :logitude)
  end

end
