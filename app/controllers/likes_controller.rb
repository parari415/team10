class LikesController < ApplicationController
  before_action :require_login

  def create
    @like = current_user.likes.build(recipe_id: params[:recipe_id])
    if @like.save
      redirect_to recipe_path(params[:recipe_id]), notice: 'いいねしました！'
    else
      redirect_to recipe_path(params[:recipe_id]), alert: 'いいねできませんでした。'
    end
  end

  def destroy
    @like = current_user.likes.find_by(recipe_id: params[:recipe_id])
    @like.destroy
    redirect_to recipe_path(params[:recipe_id]), notice: 'いいねを解除しました。'
  end

  private

  def require_login
    redirect_to top_login_path unless session[:login_uid]
  end
end
