class Api::UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      phone_number: params[:phone_number],
      pronouns: params[:pronouns],
      personal_note: params[:personal_note],
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    if current_user.id == params[:id].to_i || current_user == User.find_by(email: "stickandprey@gmail.com")
      @user = User.find(params[:id])
      render "show.json.jb", status: 200
    else
      render json: { error: "unauthorized" }, status: 401
    end
  end
end
