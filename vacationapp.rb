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
	if params[:action]=="calc_budget"
		session[:user_budget] ||= []
		session[:user_budget] = params[:budget]
		session[:transportation] = params[:transportation]
		session[:lodging] = params[:lodging]
		session[:amenities] = params[:amenities]
		session[:dining] = params[:dining]
		session[:other] = params[:other]
		budget_items = Budget.new(user_budget, transportation, lodging, amenities, dining, other)
		session[:total_box] = budget_items.remaining
	else 
		params[:budget] ||= []
		session[:user_budget] ||= []
		session[:user_budget] = params[:budget]
		session[:total_box] = session[:user_budget]
	end
	erb :budget, :locals => {:user_budget => session[:user_budget],
							 :transportation => session[:transportation],
							 :lodging => session[:lodging],
							 :amenities => session[:amenities],
							 :dining => session[:dining],
							 :other => session[:other],
							 :total_box => session[:total_box]}
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
							 :total_box => session[:total_box]}
end

class Budget
	def initialize(user_budget, transportation, lodging, amenities, dining, other)
		@totalbudget = user_budget
		@elements = [transportation, lodging, amenities, dining, other]
		@elements_total = @elements.inject(:+)
	end

	attr_reader :elements, :elements_total, :totalbudget

	def remaining
		remaining_budget = @totalbudget - @elements_total
	end
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
