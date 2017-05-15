
class FilmPrinter

  def self.print_winners(winners_store)
    winners_store.each do |winner|
      if winner[:budget] != "Not Available"
        budget = winner[:budget].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        puts "In #{winner[:year]} #{winner[:name]} won. The budget was $#{budget}"
      else
        puts "In #{winner[:year]} #{winner[:name]} won. The budget is not available"
      end
    end
  end

  def self.print_average_budget(average_budget)
    formatted_budget = average_budget.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    puts "The average budget among winners is $#{formatted_budget}"
  end
end
