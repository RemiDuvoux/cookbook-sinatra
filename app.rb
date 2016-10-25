require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

CSV_file = File.join(__dir__, 'recipes.csv')

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

get '/list' do
  @recipes = Cookbook.new(CSV_file).all
  erb :list
end

get '/create' do
  name = params[:name] || "Clafoutis"
  description = params[:description] || "Hi There"
  erb :create, :locals => {'name' => name, 'description' => description}
end

post '/recipe' do
 @recipes = Cookbook.new(CSV_file)
 recipe = Recipe.new(params[:name],params[:description])
 @recipes.add_recipe(recipe)
 erb :index
end

get '/delete' do
 @recipes = Cookbook.new(CSV_file).all
 index = params[:recipe_id] || "1"
 erb :delete, :locals => {'recipe_id' => recipe_id}
end

post '/delete_recipe' do
  @recipes = Cookbook.new(CSV_file)
  @recipes.remove_recipe(params[:recipe_id])
  erb :index

  get '/import' do
    erb :import
  end

  get '/mark_as_done' do
    erb :mark_as_done
  end
end
