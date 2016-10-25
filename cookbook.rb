require 'csv'


class Cookbook
  attr_reader :recipes
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    fetch
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save(@recipes)
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id - 1)
    save(@recipes)
  end

  def mark_as_done(done_recipe_number)
    @recipes[done_recipe_number - 1].done!
    save(@recipes)
  end

  private

  def fetch
    CSV.foreach(@csv_file) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def save(recipes)
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.cooking_time, recipe.done, recipe.difficulty]
      end
    end
  end
end
