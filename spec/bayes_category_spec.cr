require "./spec_helper"

describe Maschine do

  it "initialises correctly" do
    category = Maschine::Bayes::Category.new
    category.words.size.should eq 0
    category.word_count.should eq 0
  end

  it "sets word count" do
    category = Maschine::Bayes::Category.new
    category.word_count = 99
    category.word_count.should eq 99
  end


end

