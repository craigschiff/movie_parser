require_relative '../lib/indexParser'
require_relative '../lib/filmPrinter'

url = "http://oscars.yipitdata.com/"

  def run(url)
    movies = IndexParser.new(url)
    movies.find_winners
    FilmPrinter.print_winners(movies.winner_store)
    movies.budget_avg
  end

run(url)
