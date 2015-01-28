defmodule Tagplay do
	defmodule Client do
		defstruct token: ""
		@type t :: %{token: String.t}
	end

	defmodule ListResponse do
		@moduledoc ~S"""
		Wrapper struct around a List of responses.
		"""
		defstruct pagination: %{}, data: [], meta: %{}
		@type t :: %{pagination: Map.t, data: List.t, meta: Map.t}
	end

	defmodule RequestError do
		defexception message: "", status_code: 500
	end

	defmodule PaginationError do
		defexception message: "No more pages in that direction"
	end

	alias Tagplay.Request, as: R

	@doc ~S"""
	Create a client with the given JWT token.
	"""
	@spec client(String.t) :: Tagplay.Client.t
	def client(token), do: %Client{ token: token }

	@doc ~S"""
	Get next set of responses.
	"""
	@spec next_page(Tagplay.ListResponse.t, Client.t) :: Tagplay.ListResponse.t
	def next_page(%Tagplay.ListResponse{pagination: pagination}=_response, client) do
		if (!pagination.next_url), do: raise PaginationError
		R.get(pagination.next_url, client)
	end
	def next_page(_response, _client) do
		raise PaginationError, message: "Pagination requested on a non list object"
	end

	@doc ~S"""
	Get previous set of responses.
	"""
	@spec previous_page(Tagplay.ListResponse.t, Client.t) :: Tagplay.ListResponse.t
	def previous_page(%Tagplay.ListResponse{pagination: pagination}=_response, client) do
		if (!pagination.previous_url), do: raise PaginationError
		R.get(pagination.previous_url, client)
	end
	def previous_page(_response, _client) do
		raise PaginationError, message: "Pagination requested on a non list object"
	end

end
