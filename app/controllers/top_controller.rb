class TopController < ApplicationController
  def main
    if session[:login_uid]
      redirect_to recipes_path
    else
      render :login
    end
  end

  def login
    user = User.find_by(uid: params[:uid])
    if user && BCrypt::Password.new(user.pass) == params[:pass]
      session[:login_uid] = user.uid
      redirect_to root_path, notice: "ログインに成功しました"
    else
      render :login, alert: "ユーザーIDまたはパスワードが間違っています", status: 422
    end
  end

  def logout
    session.delete(:login_uid)
    redirect_to root_path, notice: "ログアウトしました"
  end
end
