defmodule YagoMix.MixProject do
  use Mix.Project

  def project do
    [
      app: :yago_mix,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {YagoMix.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_gram, "~> 0.6"},
      {:jason, "~> 1.1"},
      {:tesla, "~> 1.2.1"},
      {:distillery, "~> 2.0"},
      {:logger_file_backend, "0.0.10"}
    ]
  end
end
