require 'open-uri'
require 'json'
require 'byebug'
require_relative './filmParser'


class IndexParser
  attr_accessor :data_hash, :winner_store, :budgets_arr

  def initialize(url)
    response = JSON.parse(open(url).read)
    @data_hash = response['results']
    @winner_store = []
    @budgets_arr = []
  end

  def find_winners
    data_hash.each do |year|
      year['films'].each do |film|
        if film['Winner'] == true
          name = parse_name(film['Film'])
          # url = film["Detail URL"]
          year = year['year'].split(' ').first.to_i
          film_details = FilmParser.new(film["Detail URL"])
          budget = film_details.get_budget
          winner_store << {name: name, year: year, budget: budget}
          budgets_arr << budget if budget.to_i > 0
        end
          # winner_store[film['Film']] = film
      end
    end
     winner_store
  end

  def parse_name(name)
    if name.include?']'
      name = name.slice(0..name.index('[')-1)
    end
    name.rstrip
  end

  # def get_budget(url)
  #   response = JSON.parse(open(url).read)
  #   budget = response["Budget"]
  #   parse_budget(budget) if budget
  # end

  # def parse_budget(budget)
  #   if budget.include?"$"
  #   # if '$'.in? budget
  #     budget = budget.slice(budget.index('$')+1..-1)
  #     budget.split(' ').each do |term|
  #       break if term == '['
  #       budget = term if term.to_f > 0
  #     end
  #     if budget.include?","
  #       budget = budget.split(',').join('').to_i
  #     else
  #       budget = budget.to_i * 1000000
  #     end
  #   elsif budget.include?"£"
  #     budget = budget.gsub('£', '$')
  #     budget = parse_budget(budget) * 1.29
  #   else
  #     puts budget
  #   end
  #   budgets_arr << budget
  #   budget
  # end

  def budget_avg
    total = budgets_arr.inject(0) { |total, budget| total + budget }
    average_budget = (total / budgets_arr.length).round
    FilmPrinter.print_average_budget(average_budget)
  end

end
