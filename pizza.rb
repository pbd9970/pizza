class Pizza
  attr_reader :toppings
  def initialize(toppings= [Topping.new('cheese', vegetarian: true)])
    @toppings = toppings
  end

  def vegetarian?
    @toppings.all? { |top| top.vegetarian }
  end

  def add_topping(topping)
    @toppings << topping
  end

  def deliver!
    @delivery_time = Time.now + 30*60
  end

  def late?
    @delivery_time <= Time.now
  end
end

class Topping
  attr_reader :name, :vegetarian
  def initialize(name, vegetarian: false)
    @name = name
    @vegetarian = vegetarian
  end
end
