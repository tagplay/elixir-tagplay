defmodule Tagplay.Mixfile do
	use Mix.Project

	def project do
		[
			app: :tagplay,
			version: "0.1.0",
			elixir: "~> 1.0",
			deps: deps,
			description: description,
			package: package,
			name: "Tagplay",
			source_url: "https://github.com/Tagplay/elixir-tagplay",
			homepage_url: "http://tagplay.github.io"
		]
	end

	def application do
		apps = [:logger, :httpoison]
		dev_apps = Mix.env == :dev && [:reprise] || []
		[applications: dev_apps ++ apps]
	end

	defp deps do
		[
			{:ex_doc, "~> 0.6.1", only: :docs},
			{:earmark, ">= 0.1.12", only: :docs},
			{:reprise, "~> 0.3.0", only: :dev},
			{:exjsx , "~> 3.1.0"},
			{:httpoison, "~> 0.5.0"}
		]
	end

	defp description do
		"""
		Tagplay.co API client.
		"""
	end

	defp package do
		[
			contributors: ["Jón Grétar Borgþórsson"],
			licenses: ["MIT"],
			links: %{
				"Documentation": "http://hexdocs.pm/tagplay",
				"API Docs": "https://tagplay.github.io/api",
				"GitHub": "https://github.com/Tagplay/elixir-tagplay",
				"Issues": "https://github.com/Tagplay/elixir-tagplay/issues"
			}
		]
	end

end
