require 'rails_helper'

describe MoviesController do
  describe 'find movies with the same director' do
    it "should call the appropriate model's method to return similar_movies movies" do
      fake_movie = double('movie1', title: 'title')
      allow(Movie).to receive(:find_by_id).and_return(fake_movie)
      expect(Movie).to receive(:find_by_the_same_director_as).with("title").and_return("some")
      get :similar_movies, id: "1"
    end

    it "should return appropriate template to be rendered" do
      fake_movie = double('movie1', title: 'title')
      allow(Movie).to receive(:find_by_id).and_return(fake_movie)
      allow(Movie).to receive(:find_by_the_same_director_as).and_return("some")
      get :similar_movies, {id: "1"}
      expect(response).to render_template('similar_movies')
    end

    it "should access the similar_movies movies to display them on the template" do
      fake_results = [double('movie1'), double('movie2')]
      fake_movie = double('movie1', title: 'title')
      allow(Movie).to receive(:find_by_id).and_return(fake_movie)
      allow(Movie).to receive(:find_by_the_same_director_as).and_return(fake_results)
      get :similar_movies, {id: "1"}

      expect(assigns(:similar)).to eql(fake_results)
    end

    it "should redirect to root path if there are no movies similar to the provided one" do
      fake_movie = double('movie1', title: 'title')
      allow(Movie).to receive(:find_by_id).and_return(fake_movie)
      allow(Movie).to receive(:find_by_the_same_director_as).and_return(nil)
      get :similar_movies, {id: "no-similar"}

      expect(response).to redirect_to(movies_path)
    end
  end

  describe "index page" do
    it "should render the index page" do
      get :index
      expect(response).to render_template('index')
    end

    it "should set @title_header when sorting by title" do
      get :index, {sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end

    it "should set @title_header when sorting by title" do
      get :index, {sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end

    it "should set @date_header when sorting by date" do
      get :index, {sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
    end
  end

  describe "show page" do
    movie = FactoryGirl.create(:movie)
    it "should render show page for movie" do
      get :show, {id: movie.id}
      expect(response).to render_template('show')
    end

    it 'should return movie instance variable' do
      get :show, {id: movie.id}
      expect(assigns(:movie)).to eql(movie)
    end
  end

  describe "new page" do
    it 'should render new page for create action' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "create action" do
    it 'should create a new movie' do
      expect {post :create, movie: FactoryGirl.attributes_for(:movie)}.to change{Movie.count}.by 1
    end

    it 'should redirect to index page after crearting a movie' do
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'edit action' do
    movie = FactoryGirl.create(:movie)
    it 'should render edit page' do
      get :edit, {id: movie.id}
      expect(response).to render_template('edit')
    end
  end

  describe 'update action' do
    movie = FactoryGirl.create(:movie, title: 'Some Title', rating: 'PG', director: 'Some Director', release_date: '2018-05-25')

    it 'should update movie' do
      put :update, {id: movie.id, movie: FactoryGirl.attributes_for(:movie, title: 'Some Modified Title')}
      movie.reload
      expect(movie.title).to eql('Some Modified Title')
    end

    it 'should redirect to movies_path after updating' do
      put :update, {id: movie.id, movie: FactoryGirl.attributes_for(:movie, title: 'Some Modified Title')}
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe 'destroy action' do
    movie = FactoryGirl.create(:movie)
    it 'should decrease number of movies' do
      expect {delete :destroy, id: movie.id}.to change {Movie.count}.by -1
    end
  end
end