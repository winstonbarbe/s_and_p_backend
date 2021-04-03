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
    if current_user.id == params[:id].to_i || current_user.admin
      @user = User.find(params[:id])
      render "show.json.jb", status: 200
    else
      render json: { error: "unauthorized" }, status: 401
    end
  end

  def update
    if current_user.id == params[:id].to_i
      @user = current_user
      passwords = [
        params[:old_password],
        params[:password],
        params[:password_confirmation]
      ]

      @user.name = params[:name] || @user.name
      @user.email = params[:email] || @user.email
      @user.phone_number = params[:phone_number] || @user.phone_number
      @user.personal_note = params[:personal_note] || @user.personal_note
      @user.pronouns = params[:pronouns] || @user.change_password(passwords)
      # @user.change_password(passwords)
      if @user.save
        render "show.json.jb", status: 200
      else
        render json: {error: "Unauthorized"}, status: 401
      end
    end
  end
end
