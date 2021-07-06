require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: "Usama", email: "usama@example.com")
    @recipe=Recipe.create(name: "Chicken Biryani", description: "We are going to make biryani in 10 mins", chef: @chef)

    @recipe2= @chef.recipes.build(name: "Qoorma", description: "The delicious Qoorma is cooking with oil and butter")
    @recipe2.save
  end

  test "should go to recipe index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipe listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipes_path(@recipe) , text: @recipe.name
    assert_select "a[href=?]", recipes_path(@recipe) , text: @recipe.name
  end

  test "recipe should show" do
    get recipes_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body  
  end

  test "create valid recipe" do
    get new_recipe_path
  end


  test "reject invalid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ",description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
