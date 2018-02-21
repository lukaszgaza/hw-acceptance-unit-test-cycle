Given(/^the following movies exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |movie, director|
  Movie.find_by_title(movie).director == director
end

