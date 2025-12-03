defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "partA" do
    assert Day2.partA("test.txt") == 1227775554
  end

  test "partB" do
    assert Day2.partB("test.txt") == 4174379265
  end
end
