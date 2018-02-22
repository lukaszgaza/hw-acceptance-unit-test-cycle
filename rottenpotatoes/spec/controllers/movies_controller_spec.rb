require 'rails_helper'

describe MoviesController do
  describe 'find movies with the same director' do
    it "should call the appropriate model's method to return similar_movies movies" do
      expect(Movie).to receive(:find_by_the_same_director_as).with("1")
      get :similar_movies, id: "1"
    end

    it "should return appropriate template to be rendered" do
      allow(Movie).to receive(:find_by_the_same_director_as).and_return("some")
      get :similar_movies, {id: "1"}
      expect(response).to render_template('similar_movies')
    end

    it "should access the similar_movies movies to display them on the template" do
      fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_by_the_same_director_as).and_return(fake_results)
      get :similar_movies, {id: "1"}

      #expect(assigns(:similar)).to eql(fake_results)
    end

    it "should redirect to root path if there are no movies similar to the provided one" do
      allow(Movie).to receive(:find_by_the_same_director_as).and_return(nil)
      get :similar_movies, {id: "no-similar"}

      expect(response).to redirect_to(root_url)
    end
  end
end