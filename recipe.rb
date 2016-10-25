class Recipe
  attr_reader :name, :description, :cooking_time, :done, :difficulty

  def initialize(name, description, cooking_time = "", done = false, difficulty = "easy"  )
    @name = name
    @description = description
    @cooking_time = cooking_time
    @done = done
    @difficulty = difficulty
  end

  def done!
    @done = true
  end
end
