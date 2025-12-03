defmodule Solution do
  use Application

  def partA(path) do
    File.read!(path)
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Integer.digits/1)
    |> Enum.map(fn digits ->
        digits
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.map(&List.to_tuple/1)
        |> Enum.scan({ 0, 0 }, fn {digit, next_digit}, { d1, d0 }->
            cond do
              d1 < digit -> {digit, next_digit}
              d0 < digit -> {d1, digit}
              d0 < next_digit -> {d1, next_digit}
              true -> {d1, d0}
            end
        end)
        |> List.last()
        |> Tuple.to_list()
        |> Integer.undigits()
    end)
    |> Enum.sum()
  end

  def partB(path) do
    n = 12
    
    File.read!(path)
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Integer.digits/1)
    |> Enum.map(fn digits ->
        # need to ensure digit not already used - not sure how tho
        
        digits
        |> Enum.chunk_every(12, 1, :discard)
        |> Enum.scan(List.duplicate(0, n), fn digits, acc ->
          Enum.zip(digits, acc)
          |> Enum.scan({ 0, false }, fn {new, cur}, {_, replace_all} ->
              cond do
                replace_all -> { new, true }
                new > cur -> { new, true }
                new <= cur -> { cur, false }
              end
          end)
          |> Enum.map(fn {v, _} -> v end)
        end)
        |> List.last()
        |> Integer.undigits()
    end)
    |> Enum.sum()
  end

  @impl true
  def start(_type, _args) do
    IO.puts("Part A: #{partA("input.txt")}")
    IO.puts("Part B: #{partB("input.txt")}")
    {:ok, self()}
  end
end

