defmodule ElixirHW3 do
  @moduledoc false

  def word_count do
    {:ok, text} = File.read("lib/files/some_text.txt")
    String.replace(text, ~r/[\p{P}\p{S}]/, "")
    |> String.split(" ", trim: true)
    |> Enum.reduce(
         0,
         fn word, acc ->
           acc = acc + 1
         end
       )
  end

  def parallelized_word_count do
   "lib/files/some_text.txt"
   |> File.stream!(read_ahead: 100_000)
   |> Flow.from_enumerable()
  end
end
