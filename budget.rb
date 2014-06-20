require 'pry'

class Budget
	def initialize(user_budget, transportation, lodging, amenities, dining, other)
		@totalbudget = user_budget
		@transportation = transportation
		@lodging = lodging
		@amenities = amenities
		@dining = dining
		@other = other
		@elements = [@transportation, @lodging, @amenities, @dining, @other]
		@elements_total = @elements.inject(:+)
	end

	attr_reader :elements, :elements_total, :totalbudget

	def remaining
		remaining_budget = @totalbudget - @elements_total
	end
end

# def splitting(expense, people)
# 	result = expense.to_f/people.to_f
# 	return result
# end

# class Bills
# 	def initialize(transportation_bill, transportation_split, lodging_bill, lodging_split, amenities_bill, amenities_split, dining_bill, dining_split, other_bill, other_split)
# 		@transportation_bill = transportation_bill
# 		@transportation_split = transportation_split
# 		@lodging_bill = lodging_bill
# 		@lodging_split = lodging_split
# 		@amenities_bill = amenities_bill
# 		@amenities_split = amenities_split
# 		@dining_bill = dining_bill
# 		@dining_split = dining_split
# 		@other_bill = other_bill
# 		@other_split = other_split
# 	end

# 	attr_reader :transportation_bill, :transportation_split, :lodging_bill, :lodging_split, :amenities_bill, :amenities_split, :dining_bill, :dining_split, :other_bill, :other_split

# 	def splitting(expense, people)
# 		result = expense/people
# 	end
# end