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