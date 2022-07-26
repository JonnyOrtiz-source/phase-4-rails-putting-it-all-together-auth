class RecipesController < ApplicationController
    before_action :authorize

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def create
        recipe = current_user.recipes.create(recipe_params)

        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: ["Unprocessable entity"]}, status: :unprocessable_entity
        end
    end

    private 

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
  
end
