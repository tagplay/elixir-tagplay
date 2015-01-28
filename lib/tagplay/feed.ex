defmodule Tagplay.Feed do
	@moduledoc ~S"""
	"""
	alias Tagplay.Request, as: R
	alias Tagplay.Client

	@doc ~S"""
	Lists feeds inside a project.
	"""
	@spec list!(String.t, Client.t) :: Tagplay.ListResponse.t
	def list!(project_id, client), do: R.get("/project/#{project_id}/feed", client)


	@doc ~S"""
	Get feed information.
	"""
	@spec get!(String.t, String.t, Client.t) :: Map.t
	def get!(project_id, feed_id, client), do: R.get("/project/#{project_id}/feed/#{feed_id}", client)

end
