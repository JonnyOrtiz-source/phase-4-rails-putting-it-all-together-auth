class SessionsController < ApplicationController
  before_action :authorize, only: [:destroy]

  def create
    user = User.find_by(username: params[:username])
    # check username validity separately from password, and render different error messages
    if user 
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: {error: ["Invalid password: #{params[:password]}"] }, status: :unauthorized
      end
    else
      render json: {errors: ["Invalid username: #{params[:username]}"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end

end
