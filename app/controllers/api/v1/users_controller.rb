class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json(except: [:password_digest]), status: :created # 201
    else
      render json: @user.errors, status: :unprocessable_entity # 422
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :profile_image, :password, :password_confirmation, :bio)
  end

end
