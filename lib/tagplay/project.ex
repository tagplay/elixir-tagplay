defmodule Tagplay.Project do
	alias Tagplay.Request, as: R
	alias Tagplay.Client

	@doc ~S"""
	Retreive info on a specific project.
	"""
	@spec get!(String.t, Client.t) :: Map.t
	def get!(project_id, client), do: R.get("/project/#{project_id}", client)

end
