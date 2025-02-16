class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user, only: [:me]

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      @token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base[0])
      render json: {token: @token, user: {id: @user.id, username: @user.username, email: @user.email}}, status: :ok
    else
      render json: {error: "Invalid email or password"}, status: :unauthorized
    end
  end

  def me
    authenticate_user
    if @current_user
      render json: { id: @current_user.id, username: @current_user.username, email: @current_user.email }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private

  def authenticate_user
    @token = request.headers["Authorization"]&.split(" ")&.last
    @decoded = JWT.decoded(@token, Rails.application.secrets.secret_key_base[0]).first rescue nil
    @current_user = User.find(@decoded["user_id"]) if @decoded
  end
end
