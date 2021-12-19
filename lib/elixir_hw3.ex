defmodule ElixirHW3 do
  @moduledoc false

  def word_count(file_path) do
    {:ok, text} = File.read(file_path)
    count_from(text)
  end

  def word_count_by_lines(file_path) do
    streamed_file!(file_path)
    |> Enum.reduce(
         %{total: 0},
         fn line, acc ->
           Map.update!(acc, :total, & &1 + count_from(line))
         end
       )
    |> Map.get(:total)
  end

  def parallelized_word_count(file_path) do
    streamed_file!(file_path)
    |> Flow.from_enumerable()
    |> handle_and_result_flow
  end

  def count_from_files(dir_path) do
    for file <- File.ls!(dir_path) do
      streamed_file!("#{dir_path}/#{file}")
    end

    |> Flow.from_enumerables()
    |> handle_and_result_flow
  end

  defp count_from(text) do
    prepared_text(text)
    |> String.split(" ", trim: true)
    |> Enum.count
  end

  defp prepared_text(text) do
    String.replace(text, ~r/[!#$%&()*+,.:;\r\n<=>?@\^_`{|}~-]/, " ")
  end

  defp result_flow(flow) do
    Enum.reduce(
      flow,
      0,
      &elem(&1, 1) + &2
    )
  end

  defp streamed_file!(file_path) do
    File.stream!(file_path, read_ahead: 100_000)
  end

  defp handle_and_result_flow(flow) do
    Flow.partition(flow)
    |> Flow.reduce(
         fn -> %{total: 0} end,
         fn line, acc ->
           Map.update!(acc, :total, & &1 + count_from(line))
         end
       )
    |> result_flow
  end
end
