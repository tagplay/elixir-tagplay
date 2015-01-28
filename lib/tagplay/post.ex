defmodule Tagplay.Post do
	alias Tagplay.Request, as: R
	alias Tagplay.Client

	@doc ~S"""
	List public posts for a feed
	"""
	@spec list!(String.t, String.t, Client.t) :: Tagplay.ListResponse.t
	def list!(project_id, feed_id, client), do: R.get("/project/#{project_id}/feed/#{feed_id}/post", client)

	@doc ~S"""
	Get a specific posts info.
	"""
	@spec get!(String.t, String.t, String.t, Client.t) :: Map.t
	def get!(project_id, feed_id, post_id, client) do
		R.get("/project/#{project_id}/feed/#{feed_id}/post/#{post_id}", client)
	end

	@doc ~S"""
	Like a post.
	"""
	@spec like!(String.t, String.t, String.t, Client.t) :: nil
	def like!(project_id, feed_id, post_id, client) do
		R.post("/project/#{project_id}/feed/#{feed_id}/post/#{post_id}/like", client)
	end

	@doc ~S"""
	Unlike a post.
	"""
	@spec unlike!(String.t, String.t, String.t, Client.t) :: nil
	def unlike!(project_id, feed_id, post_id, client) do
		R.post("/project/#{project_id}/feed/#{feed_id}/post/#{post_id}/unlike", client)
	end

	@doc ~S"""
	Flag a post.
	"""
	@spec flag!(String.t, String.t, String.t, Client.t) :: nil
	def flag!(project_id, feed_id, post_id, client) do
		R.post("/project/#{project_id}/feed/#{feed_id}/post/#{post_id}/flag", client)
	end

	@doc ~S"""
	Unflag a post.
	"""
	@spec unflag!(String.t, String.t, String.t, Client.t) :: nil
	def unflag!(project_id, feed_id, post_id, client) do
		R.post("/project/#{project_id}/feed/#{feed_id}/post/#{post_id}/unflag", client)
	end

end
