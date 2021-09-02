require "./spec_helper"

describe Maschine::Bayes::BayesClassifier do

  describe "initialisation" do
    categories = [
      "cat 1",
      "cat 2"
      ]

    classifier = Maschine::Bayes::BayesClassifier.new(categories)
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
      classifier = Maschine::Bayes::BayesClassifier.new(categories)
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

  describe "#classify_with_score" do
    categories = [
      "AAA",
      "BBB"
      ]

    classifier = Maschine::Bayes::BayesClassifier.new(categories)
    classifier.train("AAA", "cat")
    classifier.train("AAA", "cat beaver")
    classifier.train("BBB", "dog")

    it "recognises a cat" do
      result = classifier.classify_with_score("a cat")
      result.has_key?("AAA").should be_true
			result["AAA"].should be > 4.0
    end

    it "recognises a dog" do
      result = classifier.classify_with_score("a dog")
      result.has_key?("BBB").should be_true
			result["BBB"].should be > 3.0
    end
  end

  describe "#classify" do
    categories = [
      "AAA",
      "BBB"
      ]

    classifier = Maschine::Bayes::BayesClassifier.new(categories)
    classifier.train("AAA", "cat")
    classifier.train("AAA", "cat beaver")
    classifier.train("BBB", "dog")

    it "recognises a cat" do
      result = classifier.classify("a cat")
      result.should eq "AAA"
    end

    it "recognises a dog" do
      result = classifier.classify("a dog")
      result.should eq "BBB"
    end
  end

  describe "#count_words_occurence" do
    classifier = Maschine::Bayes::BayesClassifier.new([] of String)

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

