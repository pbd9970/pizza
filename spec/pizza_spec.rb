require './pizza'
require 'pry-debugger'
require 'timecop'

describe Pizza do
  it "exists" do
    expect(Pizza).to be_a(Class)
  end
  describe '.initialize' do
    it 'records all of the toppings' do
      toppings = [
        Topping.new('mushrooms', vegetarian: true),
        Topping.new('pepperoni')
      ]
      pizza = Pizza.new(toppings)

      expect(pizza.toppings).to eq(toppings)
    end
    it 'defaults the toppings to cheese only, if the pizza has no toppings' do
      pizza = Pizza.new

      expect(pizza.toppings.size).to eq(1)
      expect(pizza.toppings.first.name).to eq('cheese')
    end
  end
  describe '.vegetarian?' do
    it 'tests whether a pizza is vegetarian' do
      toppings = [
        Topping.new('mushrooms', vegetarian: true),
        Topping.new('bell peppers', vegetarian: true),
        Topping.new('onions', vegetarian: true),
      ]
      pizza = Pizza.new(toppings)

      expect(pizza.vegetarian?).to be(true)

      toppings = [
        Topping.new('mushrooms', vegetarian: true),
        Topping.new('italian sausage'),
      ]
      new_pizza = Pizza.new(toppings)

      expect(new_pizza.vegetarian?).to be(false)
    end
  end
  describe '.add_topping' do
    it 'can add a topping' do
      pizza = Pizza.new()

      expect(pizza.toppings.first.name).to eq('cheese')
      
      pizza.add_topping(Topping.new('pepperoni'))

      toppings_reported = pizza.toppings.delete_if {|top| top.name == 'cheese'}

      expect(toppings_reported.first.name).to eq('pepperoni')
    end
  end
  describe '.deliver!' do
    it 'can be scheduled for delivery' do
      pizza = Pizza.new()

      Timecop.freeze(Time.now)

      expect(pizza.deliver!).to eq(Time.now + 30*60)
    end
  end
  describe '.late?' do
    it 'tests whether a delivery is late' do
      pizza = Pizza.new()

      pizza.deliver!

      expect(pizza.late?).to eq(false)

      Timecop.travel(Time.now + 31*60)

      expect(pizza.late?).to eq(true)
    end
  end
end

describe Topping do
  it "exists" do
    expect(Topping).to be_a(Class)
  end
  describe '.initialize' do
    it "sets the name of the topping" do
      topping = Topping.new('olives')

      expect(topping.name).to eq('olives')
    end
    it "sets whether or not the topping is vegetarian" do
      topping = Topping.new 'bell peppers', vegetarian: true

    expect(topping.vegetarian).to eq(true)    
    end
  end
end
