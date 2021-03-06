class FamilyRecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_family_recipe, only: [:show, :edit, :update, :destroy]

  # GET /family_recipes
  # GET /family_recipes.json
  def index
    if params[:search_for]
      @family_recipes = FamilyRecipe.search_for(params[:search_for]).published
    else
      @family_recipes = FamilyRecipe.published.sorted
    end
  end

  def my_recipe
    if params[:search]
      @family_recipes = current_user.family_recipes.search(params[:search]).sorted
    else
      @family_recipes = current_user.family_recipes.sorted
    end
  end

  # GET /family_recipes/1
  # GET /family_recipes/1.json
  def show
  end

  # GET /family_recipes/new
  def new
    @family_recipe = current_user.family_recipes.build
  end

  # GET /family_recipes/1/edit
  def edit
  end

  # POST /family_recipes
  # POST /family_recipes.json
  def create
    @family_recipe = current_user.family_recipes.build(family_recipe_params)

    respond_to do |format|
      if @family_recipe.save
        format.html { redirect_to my_recipe_family_recipes_path, notice: 'New recipe was successfully created.' }
        format.json { render :show, status: :created, location: @family_recipe }
      else
        format.html { render :new }
        format.json { render json: @family_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /family_recipes/1
  # PATCH/PUT /family_recipes/1.json
  def update
    respond_to do |format|
      if @family_recipe.update(family_recipe_params)
        format.html { redirect_to @family_recipe, notice: "'#{@family_recipe.title}' recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @family_recipe }
      else
        format.html { render :edit }
        format.json { render json: @family_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /family_recipes/1
  # DELETE /family_recipes/1.json
  def destroy
    @family_recipe.destroy
    respond_to do |format|
      format.html { redirect_to my_recipe_family_recipes_url, notice: "'#{@family_recipe.title}' recipe was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family_recipe
      @family_recipe = FamilyRecipe.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_recipe_params
      params.require(:family_recipe).permit(:title, :category, :short_description, :country, :publish, :long_description, ingredients_attributes: [:id, :ingredient, :done, :_destroy], cooking_directions_attributes: [:id, :step, :direction, :_destroy])
    end
end
