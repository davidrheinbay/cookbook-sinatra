require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @filepath = csv_file_path
    CSV.foreach(@filepath) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    save_in_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_in_csv
  end

  def mark_recipe_as_done(recipe_index)
    @recipes[recipe_index].mark_as_done
    save_in_csv
  end

  def save_in_csv
    CSV.open(@filepath, 'wb', force_quotes: true) do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty] }
    end
  end
end
