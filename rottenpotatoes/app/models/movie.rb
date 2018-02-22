class Movie < ActiveRecord::Base
  def Movie.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def Movie.find_by_the_same_director_as(title)
    movie = Movie.find_by_title(title)
    return nil if movie.director.nil? or movie.director.empty?
    [Movie.where(director: movie.director)].flatten
  end
end
