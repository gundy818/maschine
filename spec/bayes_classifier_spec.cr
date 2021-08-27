require "./spec_helper"

describe Machine::Bayes::BayesClasifier do

  describe "initialisation" do
    categories = [
      "cat 1",
      "cat 2"
      ]

    classifier = Machine::Bayes::BayesClasifier.new(categories)
    classifier.categories.size.should eq categories.size


    it "creates categories" do
      categories.each do |cat|
        classifier.categories.has_key?(cat).should be_true
      end
    end

    it "sets category counts to zero" do
      categories.each do |cat|
        classifier.category_counts[cat].should eq 0
      end
    end
  end

  describe "#train" do
    categories = [
      "AAA",
      "BBB"
      ]

    it "trains a category" do
      classifier = Machine::Bayes::BayesClasifier.new(categories)
      classifier.train("AAA", "cat")
      classifier.category_counts["AAA"].should eq 1

      cat = classifier.categories["AAA"]
      cat.words["cat"].should eq 1
      cat.word_count.should eq 1

      classifier.train("AAA", "cat beaver")
      cat.words["cat"].should eq 2
      cat.words["beaver"].should eq 1
      cat.word_count.should eq 3
    end
  end

  pending "#classifications" do
  end

  pending "#classify_with_score" do
  end

  pending "#classify" do
    categories = [
      "AAA",
      "BBB"
      ]

    classifier = Machine::Bayes::BayesClasifier.new(categories)
  end

  describe "#count_words_occurence" do
    classifier = Machine::Bayes::BayesClasifier.new([] of String)

    it "handles empty string" do
      occ = classifier.count_words_occurence("")
      occ.size.should eq 0
    end

    it "handles duplicate words" do
      occ = classifier.count_words_occurence("aaa b aaa b aaa cc")
      occ.size.should eq 3
      occ["aaa"].should eq 3
      occ["b"].should eq 2
      occ["cc"].should eq 1
    end

    it "is case sensitive" do
      occ = classifier.count_words_occurence("a bb ccc A BB CCC")
      occ.size.should eq 6
      occ["a"].should eq 1
      occ["bb"].should eq 1
      occ["ccc"].should eq 1
      occ["A"].should eq 1
      occ["BB"].should eq 1
      occ["CCC"].should eq 1
    end
  end
end

