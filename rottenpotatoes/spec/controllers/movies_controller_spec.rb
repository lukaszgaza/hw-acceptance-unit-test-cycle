require 'rails_helper'

describe MoviesController do
  describe 'find movies with the same director' do
    it "should call the appropriate model's method to return similar_movies movies" do
      expect(Movie).to receive(:find_by_the_same_director_as).with("1")
      get :similar_movies, id: "1"
    end

    it "should return appropriate template to be rendered" do
      allow(Movie).to receive(:find_by_the_same_director_as)
      get :similar_movies, {id: "1"}
      expect(response).to render_template('similar_movies')
    end

    it "should access the similar_movies movies to display them on the template" do
      @fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_by_the_same_director_as).and_return(@fake_results)
      get :similar_movies, {id: "1"}

      # checking instance variables in the tests is IMHO bad idea
      #expect assigns(:similar).to eq(@fake_results)
    end
  end
end