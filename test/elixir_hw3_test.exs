defmodule ElixirHW3Test do
  use ExUnit.Case
  doctest ElixirHW3

  describe "word_count/1" do
    test "count number of words from a file" do
      assert ElixirHW3.word_count("test/files/some_text.txt") == 320
    end
  end

  describe "word_count_by_lines/1" do
    test "count number of words from a file by lines" do
      assert ElixirHW3.word_count_by_lines("test/files/some_text.txt") == 320
    end
  end

  describe "parallelized_word_count/1" do
    test "count number of words from a file by lines" do
      assert ElixirHW3.parallelized_word_count("test/files/some_text.txt") == 320
    end
  end

  describe "count_from_files/1" do
    test "count number of words from a file by lines" do
      assert ElixirHW3.count_from_files("test/files") == 640
    end
  end
end
