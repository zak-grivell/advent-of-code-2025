defmodule Day2 do
  use Application

  def partA(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "-", trim: true))
    |> Enum.flat_map(fn [begin, stop] -> String.to_integer(begin)..String.to_integer(stop) end)
    |> Enum.map(&Integer.digits(&1))
    |> Enum.filter(fn digits ->
        {a, b} = Enum.split(digits, Integer.floor_div(length(digits),2))

        a == b
    end)
    |> Enum.map(&Integer.undigits(&1))
    |> Enum.sum()
  end

  def partB(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "-", trim: true))
    |> Enum.flat_map(fn [begin, stop] -> String.to_integer(begin)..String.to_integer(stop) end)
    |> Enum.map(&Integer.digits(&1))
    |> Enum.filter(fn digits ->
        (1..Integer.floor_div(length(digits),2)//1)
        |> Enum.any?(fn size ->
            res = Enum.chunk_every(digits, size)
            |> Enum.uniq()

            length(res) == 1
            end)
        end)
    |> Enum.map(&Integer.undigits(&1))
    |> Enum.sum()
  end

  @impl true
  def start(_type, _args) do
    IO.puts("Part A: #{partA("input.txt")}")
    IO.puts("Part B: #{partB("input.txt")}")
    {:ok, self()}
  end
end

