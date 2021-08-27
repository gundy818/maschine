require "./spec_helper"

describe Machine do

  it "initialises correctly" do
    category = Machine::Bayes::Category.new
    category.words.size.should eq 0
    category.word_count.should eq 0
  end

  it "sets word count" do
    category = Machine::Bayes::Category.new
    category.word_count = 99
    category.word_count.should eq 99
  end


end

