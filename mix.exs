defmodule MarkdownToHtml.MixProject do
  use Mix.Project

  def project do
    [
      app: :markdown_to_html,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:earmark, "~> 1.4"}
    ]
  end

  defp escript do
    System.argv() |> IO.inspect(label: ~S[System.argv])

    {opts, _} = OptionParser.parse!(System.argv(), switches: [path: :string])
    path = Keyword.get(opts, :path)

    [
      main_module: MarkdownToHtml,
      path: path
    ]
  end
end
