require 'rails_helper'

describe MoviesHelper do
  it "should return 'odd' for odd number" do
    expect(oddness(1)).to eql('odd')
  end

  it "should return 'even' for even number" do
    expect(oddness(2)).to eql('even')
  end
end