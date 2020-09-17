class AuthController < ApplicationController
  def login
    user = User.find_by(username: params[:username])
    if user and user.password == (params[:password])
      payload = {user_id: user.id}
      token = encode_token(payload)
      render json: {user: user, jwt: token, success: "Welcome back, #{user.username}"}
    else
      render json: {failure: "Log in failed! Username or password invalid!"}
    end
  end

  def auto_login
    if session_user
      render json: session_user
    else
      render json: {errors: "No User Logged In"}
    end
  end

  def user_is_authed
    if session_user
      render json: {message: "Logined"}
    else
      render json: {message: "Please Login"}
    end
  end

end
