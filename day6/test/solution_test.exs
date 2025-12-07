defmodule SolutionTest do
  use ExUnit.Case
  doctest Solution

  test "partA" do
    assert Solution.partA("test.txt") == 357
  end

  test "partB" do
    # assert Solution.partB("test.txt") == 4174379265
  end
end
