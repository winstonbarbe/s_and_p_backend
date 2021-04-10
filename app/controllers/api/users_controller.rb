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
    user_id = params[:id].to_i
    if current_user.is_allowed(user_id)
      @user = User.find(user_id)
      render "show.json.jb", status: 200
    else
      render json: { error: "unauthorized" }, status: 401
    end
  end

  def update
    user_id = params[:id].to_i
    if current_user.is_allowed(user_id)
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
      @user.pronouns = params[:pronouns] || @user.pronouns
      if params[:old_password] && params[:password] && params[:password_confirmation]
        if @user.authenticate(params[:old_password])
          @user.update!(
            password: params[:password],
            password_confirmation: params[:password_confirmation],
          )
        end
      end
      if @user.save
        render "show.json.jb", status: 200
      else
        render json: {error: "Unauthorized"}, status: 401
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user || current_user.admin
      user.destroy
      render json: { message: "Account Destroyed"}, status: 201
    else
      render json: { errors: "Unauthorized"}, status: 400
    end
  end
end
