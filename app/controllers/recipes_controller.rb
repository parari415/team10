class RecipesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    ingredients = params[:recipe][:ingredients].split(',').map(&:strip)
    genre = params[:recipe][:genre]
    free_word = params[:recipe][:free_word]

    # ChatGPTを利用してレシピを生成
    chat_gpt_service = ChatGptService.new(ENV['OPENAI_API_KEY'])
    generated_recipe = chat_gpt_service.generate_recipe(ingredients, genre, free_word)

    # 生成されたレシピを保存
    @recipe = current_user.recipes.build(
      title: generated_recipe[:title],
      genre: genre,
      ingredients: ingredients.join(', '),
      instructions: generated_recipe[:instructions],
      calories: generated_recipe[:calories]
    )

    if @recipe.save
      redirect_to @recipe, notice: 'レシピが作成されました。'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'レシピが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'レシピが削除されました。'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :genre, :ingredients, :instructions, :calories)
  end

  def require_login
    redirect_to top_login_path unless session[:login_uid]
  end
end
