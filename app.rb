require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "lib/cookbook"

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

cookbook = Cookbook.new('lib/recipes.csv')

get '/' do # <--- Router
  @recipes = cookbook.all
  erb :index # <-------- Controller
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

get '/new' do
  erb :new
end

get '/create' do
  name = params['name']
  description = params['description']
  prep_time = params['prep_time']
  difficulty = params['difficulty']
end

cookbook.all.each do |recipe|
  get "/#{recipe.name.downcase.split(' ').join('-')}" do
    @recipe = recipe
    erb :recipesites
  end
end


post '/recipes' do
  name = param[:name]
  name = param[:name]
  name = param[:name]
  name = param[:name]
  cookbook.add_recipe(Recipe.new(name, description, prep_time, difficulty))
end
