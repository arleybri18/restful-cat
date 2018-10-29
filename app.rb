require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/cat.db")
class Cat
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :image, Text
end
DataMapper.finalize.auto_upgrade!

#index
get '/cats' do
	@cats = Cat.all
	erb :'cats/index'
end

#new
get '/cats/new' do
	erb :'cats/new'
end

#create
post '/cats' do
	Cat.create({:name => params[:name],:image => params[:image]})
	redirect '/cats'
end 

# show (se debe definir una variable de ruta)
get '/cats/:id' do 
  @cat = Cat.get(params[:id])
  erb :"cats/show"
end