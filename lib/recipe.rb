class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  def initialize(name, description, prep_time, difficulty = nil)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = false
    @difficulty = difficulty
  end

  def mark_as_done
    @done = true
  end

  def done?
    @done
  end

  def difficulty_converter
    case @difficulty.to_i
    when 1
      "Very easy"
    when 2
      "Easy"
    when 3
      "Moderate"
    else
      ""
    end
  end
end
