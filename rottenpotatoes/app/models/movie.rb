class Movie < ActiveRecord::Base
  def Movie.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def Movie.find_by_the_same_director_as(id)
    #@movie = Movie.find_by_id(id)
    #Movie.find_by_director(@movie.director)
  end
end
