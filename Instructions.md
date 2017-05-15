Data Product Engineers at YipitData need to be able to extract messy data from external websites in a clean and robust manner.

So, we’ve written a messy API for you to extract data from: http://oscars.yipitdata.com

This API represents a list of films nominated for the Academy Award for Best Picture, which has been pulled from Wikipedia. Each film has an associated “Detail URL” which refers to another page that contains additional information about that film, such as the budget.

The challenge is to write a script to go the main API page, follow the “Detail URL” link for each year’s winner, grab the budget, and print out each Year-Title-Budget combination. After printing each combination, it should print the average budget of all the winners at the end.

If you encounter any edge cases, feel free to use your best judgement and add a comment with your conclusion. This code should be written to production standards.

You can use any language you want, but there is a strong preference for a language where we will be able to reproduce your results (any modern, semi-popular language will be fine).

Although the challenge typically takes three to four hours, you will haveyou will have 24 hours upon receiving this prompt to submit your solution as a .ZIP file, which should contain:

Your script
Instructions on how to run your script, including any additional libraries and their versions
The average budget of all the winners
Brief summary of your approach
Please submit to: https://app.greenhouse.io/tests/65484721e0ec51cc8ef7141e3316e3dc.
