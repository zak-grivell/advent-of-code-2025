defmodule Day1 do
  use Application

  def partA(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      <<"R", num::binary>> -> elem(Integer.parse(num), 0)
      <<"L", num::binary>> -> -elem(Integer.parse(num), 0)
    end)
    |> Enum.scan(50, fn item, acc ->
      Integer.mod(item + acc, 100)
    end)
    |> Enum.reduce(0, fn item, acc ->
      if item == 0, do: acc + 1, else: acc
    end)
  end

  def partB(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      <<"R", num::binary>> -> elem(Integer.parse(num), 0)
      <<"L", num::binary>> -> -elem(Integer.parse(num), 0)
    end)
    |> Enum.flat_map(fn item ->
      List.duplicate(if(item > 0, do: 1, else: if(item < 0, do: -1, else: 0)), abs(item))
    end)
    |> Enum.scan(50, fn item, acc ->
      Integer.mod(item + acc, 100)
    end)
    |> Enum.reduce(0, fn item, acc ->
      if item == 0, do: acc + 1, else: acc
    end)
  end

  @impl true
  def start(_type, _args) do
    IO.puts("Part A: #{partA("input.txt")}")
    IO.puts("Part B: #{partB("input.txt")}")
    {:ok, self()}
  end
end
