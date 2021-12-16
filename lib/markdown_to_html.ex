defmodule MarkdownToHtml do
  def main(argv) do
    Application.put_env(:earmark, :sys_interface, MarkdownToHtml.SysInterface)
    Earmark.Cli.run!(argv) |> IO.puts()
  end
end

defmodule MarkdownToHtml.SysInterface do
  @behaviour Earmark.SysInterface.Behavior

  @doc """
  A proxy to IO.stream(..., :line) or usage with a filename
  """
  @impl true
  def readlines(device_or_filename)

  def readlines(filename) when is_binary(filename) do
    IO.inspect(filename, label: :inside)

    case File.open(filename, [:utf8]) do
      {:ok, device} -> readlines(device)
      {:error, _} = error -> error
    end
  end

  def readlines(device) do
    IO.stream(device, :line)
  end
end
