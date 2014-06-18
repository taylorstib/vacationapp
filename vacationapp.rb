require 'sinatra'
require 'sinatra/reloader'

configure do
	enable :sessions
end

get '/' do
	session[:user_budget] ||= []
 	erb :index, :locals => {:user_budget => session[:user_budget]}
end

post '/budget' do
	params[:budget] ||= []
	session[:user_budget] ||= []
	session[:user_budget] = params[:budget]
	erb :budget, :locals => {:user_budget => session[:user_budget]}
end

get '/budget' do
	erb :budget, :locals => {:user_budget => session[:user_budget]}
end

class Budget
	def self.add


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
