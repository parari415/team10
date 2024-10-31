class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:user][:password] # ハッシュ化したパスワードを保存

    if @user.save
      session[:login_uid] = @user.uid
      redirect_to root_path, notice: "ユーザー登録が完了しました。"
    else
      render :new, alert: "登録に失敗しました。再度お試しください。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, :password)
  end
end
