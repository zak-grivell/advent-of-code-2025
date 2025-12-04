defmodule Solution do
  use Application

  def parse_input(str) do
    String.split(str, "\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      String.graphemes(line)
      |> Enum.with_index()
      |> Enum.filter(fn {c, x} ->
          c == "@"
      end)
      |> Enum.map(fn {c, x} ->
          {x, y}
        end)
    end)
    |> MapSet.new()
  end

  def partA(path) do
    grid = File.read!(path)
      |> parse_input()

    Enum.filter(grid, fn {x,y} ->
      [
        {1,1},
        {1,0},
        {1, -1},
        
        {-1,1},
        {-1,0},
        {-1,-1},
        
        {0, 1},
        {0, -1}
      ]
      |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
      |> Enum.filter(fn p -> MapSet.member?(grid, p) end)
      |> Enum.count() < 4
    end)
    |> Enum.count()
  end

  def repeated_remove(grid) do
    it1 = Enum.filter(grid, fn {x,y} ->
      [
        {1,1},
        {1,0},
        {1, -1},
        
        {-1,1},
        {-1,0},
        {-1,-1},
        
        {0, 1},
        {0, -1}
      ]
      |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
      |> Enum.filter(fn p -> MapSet.member?(grid, p) end)
      |> Enum.count() < 4
    end)
    |> MapSet.new()

    case MapSet.size(it1) do
      0 -> 0
      x -> x + repeated_remove(MapSet.difference(grid, it1))

    end    
  end

  def partB(path) do
    grid = File.read!(path)
      |> parse_input()

    repeated_remove(grid)
  end

  @impl true
  def start(_type, _args) do
    # IO.puts("Part A: #{partA("input.txt")}")
    # IO.puts("Part B: #{partB("input.txt")}")
    {:ok, self()}
  end
end

