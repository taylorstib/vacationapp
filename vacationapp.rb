require 'sinatra'
# require 'sinatra/reloader'
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
		session[:destination] = params[:destination]
		session[:transportation_type] = params[:transportation_type]
		session[:user_budget] = params[:budget].to_f
		session[:total_box] = session[:user_budget].to_f
		end
	erb :budget, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :destination => session[:destination],
							 :total_box => session[:total_box],
							 :total_box_update => session[:total_box_update]}
end

get '/budget' do
	session ||= {}
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
							 :result_split_user => session[:result_split_user]}
end

post '/bills'  do

	if 	params[:split_transportation] == "Split it!"
		session[:result_transportation] = (params[:transportation_bill].to_f/params[:transportation_user1].to_f).round(2)
		elsif
			params[:split_lodging] == "Split it!"
			session[:result_lodging] = (params[:lodging_bill].to_f/params[:lodging_user1].to_f).round(2)
		elsif
			params[:split_amenities] == "Split it!"
			session[:result_amenities] = (params[:amenities_bill].to_f/params[:amenities_user1].to_f).round(2)
		elsif
			params[:split_dining] == "Split it!"
			session[:result_dining] = (params[:dining_bill].to_f/params[:dining_user1].to_f).round(2)
		elsif
			params[:split_other] == "Split it!"
			session[:result_other] = (params[:other_bill].to_f/params[:other_user1].to_f).round(2)
	end


	erb :bills, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :total_box => session[:total_box],
							 :result_transportation => session[:result_transportation],
							 :result_lodging => session[:result_lodging],
							 :result_amenities => session[:result_amenities],
							 :result_dining => session[:result_dining],
							 :result_other => session[:result_other]}
end

get '/checklist' do
	params[:todo] ||= []
	session[:user_todo] ||= []
	array_todo = ['Take out the Trash before you leave.', 'Print boarding passes']
	erb :checklist, :locals => {:array_todo => array_todo,
								:user_todo => session[:user_todo]}
end


post '/checklist' do
	params[:todo] ||= []
	session[:user_todo] ||= []
	array_todo = ['Take out the Trash before you leave.', 'Print boarding passes']
	new_todo = params[:todo]
	session[:user_todo].push(new_todo)
	erb :checklist, :locals => {:array_todo => array_todo, :user_todo => session[:user_todo]}
end

get '/print' do
	dont_forget = ['Take out the Trash before you leave.', 'Print boarding passes']
	erb :print, :locals => {:destination => session[:destination],
							:transportation_type => session[:transportation_type],
							:dont_forget => dont_forget}
end

get '/transportation' do
	erb :transportation
end

get '/lodging' do
	erb :lodging
end
