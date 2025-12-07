defmodule Solution do
  use Application

  def partA(path) do
    lines = File.read!(path)
    |> String.split("\n", trim: true)

    numbers = Enum.slice(lines, 0..length(lines)-2)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> Enum.map(&String.trim(&1))
      |> Enum.map(&String.to_integer(&1))
    end)

    symbols = List.last(lines)
    |> String.split(" ", trim: true)


    Enum.zip(numbers)
    |> Enum.zip(symbols)
    |> IO.inspect()
    |> Enum.map(fn {nums, symbol} -> {Tuple.to_list(nums), symbol} end)
    |> Enum.map(fn {nums, symbol} ->
      case symbol do
        "+" -> Enum.sum(nums)
        "*" -> Enum.product(nums)
      end
    end)
    |> Enum.sum()
  end

  def pad_left(list, len) do
    pad_count = len - length(list)
    List.duplicate(-1, pad_count) ++ list
  end



  def partB(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes(&1))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.chunk_by(fn col ->
      Enum.all?(col, &(&1 == " "))
    end)
    |> Enum.filter(fn col ->
        List.first(col)
        |> Enum.any?(&(&1 != " "))
      end)
    |> Enum.map(fn calculation ->
      {
        List.first(calculation)
        |> List.last(),
        Enum.map(calculation, &Enum.slice(&1, 0..length(&1)-2))
        |> Enum.map(fn x ->
            Enum.join(x)
            |> String.trim()
            |> String.to_integer()
        end)
      }
    end)
    |> Enum.map(fn {symbol, nums} ->
      case symbol do
        "+" -> Enum.sum(nums)
        "*" -> Enum.product(nums)
      end
    end)
    |> Enum.sum()
  end

  @impl true
  def start(_type, _args) do
    # IO.puts("Part A: #{partA("input.txt")}")
    # IO.puts("Part B: #{partB("input.txt")}")
    {:ok, self()}
  end
end
