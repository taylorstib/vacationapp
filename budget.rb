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

class Bills
	def initialize(transportation, transportation_split, lodging, lodging_split, amenities, amenities_split, dining, dining_split, other, other_split)
		@transportation = transportation
		@transportation_split = transportation_split
		@lodging = lodging
		@lodging_split = lodging_split
		@amenities = amenities
		@amenities_split = amenities_split
		@dining = dining
		@dining_split = dining_split
		@other = other
		@other_split = other_split
	end

	def splitting
		array_bills = [@transportation, @lodging, @amenities, @dining, @other]
		array_split = [@transportation_split, @lodging_split, @amenities_split, @dining_split, @other_split]

		array_bills_split = array_bills.zip(array_split)

		@expense_per_person = []

		array_bills_split.each do |item|
			result = item[0]/item[1]
			@expense_per_person << result
		end

		sum_expense_per_person = @expense_per_person.inject(:+)
	end
end