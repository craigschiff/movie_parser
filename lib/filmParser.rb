require 'open-uri'
require 'json'
require 'byebug'

class FilmParser
  attr_accessor :film_page

  def initialize(url)
    @film_page = JSON.parse(open(url).read)
  end

  def get_budget
    budget = film_page["Budget"]
    if budget
      budget = find_budget(budget)
    else
      budget = "Not Available"
    end
    budget
  end

  def  find_budget(budget)
    if budget.include?"$"
      budget = parse_budget(budget)
      # budget = budget.slice(budget.index('$')+1..-1).split(' ')
      # budget.each do |term|
      #   break if term == '['
      #   budget = term if term.to_f > 0 # testing if its a number
      # end
      # budget = convert_budget_to_number(budget)
    elsif budget.include?"£"
      budget = parse_budget(budget.gsub('£', '$')) * 1.29 #exchange rate - recursively solving same problem with appropriate multiple
    # else
    #   puts budget
    end
    budget.round
  end

  def parse_budget(budget)
    budget = budget.slice(budget.index('$')+1..-1).split(' ')
    budget = budget.detect{ |term| term.to_f > 0 } # taking first number
    budget = convert_budget_to_number(budget)
  end

  def convert_budget_to_number(budget)
    if budget.include?"," # if has comma written in full numbers not millions
      budget = budget.split(',').join('').to_i
    else
      budget = budget.to_i * 1000000 #or else written in millions
    end
    budget
  end

end
