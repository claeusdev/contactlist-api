class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_destroyed(error)
    render json: { errors: error.record.errors }, status: :unprocessable_entity
  end

  def not_found(error)
    render json: { errors: error }, status: :unprocessable_entity
  end
end
