require 'sinatra'
require 'sinatra/reloader'

configure do
	enable :sessions
end

get '/' do
	erb :index
	#include user_budget local variable
end

post '/' do
	params[:budget] ||= []
	session[:user_budget] ||= []
	session[:user_budget] = params[:budget]
	erb :budget, :local => {:user_budget => session[:user_budget]}
end

get '/budget' do
	#show user budget
end



get '/checklist' do
	params[:todo] ||= []
	session[:user_todo] ||= []
	array_todo = ['Take out the Trash before you leave.', 'Print boarding passes']
	erb :checklist, :locals => {:array_todo => array_todo, :user_todo => session[:user_todo]}
end


post '/checklist' do
	params[:todo] ||= []
	session[:user_todo] ||= []
	array_todo = ['Take out the Trash before you leave.', 'Print boarding passes']
	new_todo = params[:todo]
	session[:user_todo].push(new_todo)
	erb :checklist, :locals => {:array_todo => array_todo, :user_todo => session[:user_todo]}
end
