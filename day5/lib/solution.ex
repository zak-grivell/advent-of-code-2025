defmodule Solution do
  use Application

  def parse_input(str) do
    [ranges, ids] = String.split(str, "\n\n")

    {
      ranges
      |> String.split("\n")
      |> Enum.map(fn line ->
        [a, b] =
          String.split(line, "-")
          |> Enum.map(fn x -> String.to_integer(x) end)

        a..b
      end),
      ids
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn x -> String.to_integer(x) end)
    }
  end

  def partA(path) do
    {ranges, ids} =
      File.read!(path)
      |> parse_input()

    ids
    |> Enum.filter(fn id ->
      ranges
      |> Enum.any?(fn range ->
        id in range
      end)
    end)
    |> Enum.count()
  end

  def combine_overlapping_ranges(ranges) do
    (Enum.map(ranges, & &1.first) |> Enum.min())..(Enum.map(ranges, & &1.last) |> Enum.max())
  end

  def flatten_ranges(ranges) do
    to_flatten = List.first(ranges)

    case length(ranges) do
      1 ->
        ranges

      _ ->
        disjointed = Enum.filter(ranges, fn range -> Range.disjoint?(to_flatten, range) end)
        to_join = Enum.filter(ranges, fn range -> not Range.disjoint?(to_flatten, range) end)

        case length(to_join) do
          1 -> [to_flatten] ++ flatten_ranges(Enum.slice(ranges, 1..length(ranges)))
          _ -> flatten_ranges(disjointed ++ [combine_overlapping_ranges(to_join)])
        end
    end
  end

  def partB(path) do
    {ranges, _ids} =
      File.read!(path)
      |> parse_input()

    flattened = flatten_ranges(ranges)

    flattened
    |> Enum.map(fn x -> x.last + 1 - x.first end)
    |> Enum.sum()
  end

  @impl true
  def start(_type, _args) do
    # IO.puts("Part A: #{partA("input.txt")}")
    # IO.puts("Part B: #{partB("input.txt")}")
    {:ok, self()}
  end
end
