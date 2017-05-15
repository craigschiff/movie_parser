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
          year = year['year'].split(' ').first.to_i
          film_details = FilmParser.new(film["Detail URL"])
          budget = film_details.get_budget
          winner_store << {name: name, year: year, budget: budget}
          budgets_arr << budget if budget.to_i > 0
        end
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


  def budget_avg
    total = budgets_arr.inject(0) { |total, budget| total + budget }
    average_budget = (total / budgets_arr.length).round
    FilmPrinter.print_average_budget(average_budget)
  end

end
