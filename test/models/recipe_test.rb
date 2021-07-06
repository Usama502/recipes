require "test_helper"

class RecipeTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.create!(name: "usama", email: "usama@gmail.com")
		@recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable")
	end

	test "recipe without chef is invalid" do
		@recipe.chef_id = nil
		assert_not @recipe.valid?
	end

	test "recipe should be valid" do
		assert @recipe.valid?
	end

	test "name should be present" do
		@recipe.name = " "
		assert_not @recipe.valid?
	end

	test "description should be present" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description should not be less than 5" do
		@recipe.description= "a" * 3
		assert_not @recipe.valid?
	end


	test "description should not be more than 500" do
		@recipe.description= "a" * 501
		assert_not @recipe.valid?
	end


end