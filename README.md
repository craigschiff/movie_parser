To run the script type "ruby bin/run.rb" from the command line.  

The average budget of all the winners that have budget information available is $17,118,754. Movies with no budget information available were removed from the calculation. Thus, the actual average over this time is likely slightly lower given the few movies with no budget information available were all pre-1955 when budgets were meaningfully lower. 

The script parses the index page, and then for each winner the FilmParser class calls the show page to get the budget info and parse it. All data is stored locally in the IndexParser class in a winner_store array. All budget info is stored in a budget array.
