defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "partA" do
    assert Day1.partA("test.txt") == 3
  end

  test "partB" do
    assert Day1.partB("test.txt") == 6
  end
end
