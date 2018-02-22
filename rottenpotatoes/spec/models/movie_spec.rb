require 'rails_helper'

describe Movie do

  describe 'Find movies similar to the provided one (with the same director)' do
    let!(:movie1) {FactoryGirl.create(:movie, title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: '1977-05-25')}
    let!(:movie2) {FactoryGirl.create(:movie, title: 'Blade Runner', rating: 'PG', director: 'Ridley Scott', release_date: '1982-06-25')}
    let!(:movie3) {FactoryGirl.create(:movie, title: 'Alien', rating: 'R', director: '', release_date: '1979-05-25')}
    let!(:movie4) {FactoryGirl.create(:movie, title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: '1971-03-11')}

    it 'should return all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end

    it 'should find similar movies when director exists' do
      expect(Movie.find_by_the_same_director_as(movie1.title).map(&:title)).to eql(['Star Wars', 'THX-1138'])
      expect(Movie.find_by_the_same_director_as(movie1.title)).to_not include([movie2])
    end

    it 'should return nil for similar movies if director does not exist' do
      expect(Movie.find_by_the_same_director_as(movie3.title)).to be_nil
    end
  end
end