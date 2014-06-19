require 'sinatra'
require 'sinatra/reloader'
require_relative 'budget.rb'

configure do
	enable :sessions
end

get '/' do
	session[:user_budget] ||= []
 	erb :index, :locals => {:user_budget => session[:user_budget]}
end

post '/budget' do
		if params[:action] == "Calculate"
		session[:user_budget] = params[:totalbudget].to_f
		session[:transportation] = params[:transportation].to_f
		session[:lodging] = params[:lodging].to_f
		session[:amenities] = params[:amenities].to_f
		session[:dining] = params[:dining].to_f
		session[:other] = params[:other].to_f
		budget_items = Budget.new(session[:user_budget] , session[:transportation], session[:lodging], session[:amenities], session[:dining], session[:other]) 
		session[:total_box_update] = budget_items.remaining.to_f
	 else
		params[:budget] ||= []
		session[:user_budget] ||= []
		session[:user_budget] = params[:budget].to_f
		session[:total_box] = session[:user_budget].to_f
	end
	erb :budget, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :total_box => session[:total_box],
							 :total_box_update => session[:total_box_update]}
end

get '/budget' do
	session ||= {}
	# session[:totalbudget] = session[:user_budget]
	# took out the params stuff
	erb :budget, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :total_box => session[:total_box],
							 :total_box_update => session[:total_box_update]}
end

get '/bills' do
	session ||= {}

	erb :bills, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :total_box => session[:total_box],
							 :total_box_update => session[:total_box_update]}
end

post '/bills'  do
	erb :bills, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :total_box => session[:total_box],
							 :total_box_update => session[:total_box_update]}
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
