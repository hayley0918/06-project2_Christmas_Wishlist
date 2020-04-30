require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg' 
require 'pry' if development?

require_relative 'models/user'
require_relative 'models/item'
require_relative 'lib'

enable :sessions 

get '/' do
  erb :index
end


get '/login' do
  erb :login
end


post '/login' do
  user = find_one_user_by_email( params[:email] )

  if user && BCrypt::Password.new(user["password_digest"]) == params[:password]
    session[:user_id] = user['id']
    redirect "/loggedin"
  else
    erb :login
  end
end



get '/loggedin' do
  user = find_one_user_by_id(session[:user_id])

  erb :loggedin, locals:{
    user: user
  }
end


get '/mylist' do
  items = find_all_items_by_user_id(session[:user_id])
 
  erb :mylist, locals:{items: items}
end

post '/mylist' do
  if !logged_in?
    redirect "/login"
  end

  items = find_all_items_by_user_id(session[:user_id])

  create_item(params[:name], params[:image_url], params[:price], params[:reason], session[:user_id])
  erb :mylist, locals:{ items: items }

  redirect '/mylist'
end


get '/items/new' do
  erb :new
end


delete '/items' do
  delete_item(params[:id])

  redirect "/mylist"
end


get '/items/:id/edit' do
  item = find_one_item_by_id(params[:id])

  erb :edit, locals: { item: item }
end


patch '/items' do
  update_item(
    params[:id],
    params[:name], 
    params[:image_url],
    params[:price],
    params[:reason]
  )
  redirect "/mylist"  
end


delete '/logout' do
  session[:user_id] = nil
  redirect "/"
end


get '/signup' do 
  erb :signup
end

post '/signup' do 
  create_user(params[:email], params[:password])
  user = find_one_user_by_email( params[:email] )
  session[:user_id] = user['id']
  redirect '/loggedin'
end

# # making public page 
# get '/mylist/:id/public' do 
#   user = find_one_user_by_id(params[:id])
#   items = find_all_items_by_user_id(params[:id])

#   # guard 
#   if user["public"] 
#     erb :mylist, locals:{items: items, user: user}
#   else
#     redirect '/'
#   end
 
# end
