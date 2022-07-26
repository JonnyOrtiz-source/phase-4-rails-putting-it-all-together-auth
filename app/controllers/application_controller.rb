class ApplicationController < ActionController::API
  include ActionController::Cookies

  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def current_user
    User.find_by(id: session[:user_id])
  end
  
  private

  def authorize
    return render json: {errors: ["Unauthorized"]}, status: :unauthorized unless session.include? :user_id
  end

  # def render_unprocessable_entity(invalid)
  #     render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  # end 

end
