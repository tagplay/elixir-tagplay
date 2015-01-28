defmodule Tagplay.Request do
	use HTTPoison.Base
	@moduledoc false

	@default_headers [{"User-agent", "ElixirTagplay"}]

	@type response :: Tagplay.ListResponse.t | :jsx.json_term

	def process_url(url) do
		server = Application.get_env(:tagplay, :server, "https://api.tagplay.co/v1")
		server <> url
	end

	@spec process_response(HTTPoison.Response.t) :: response
	def process_response(response) do
		status_code = response.status_code
		body = response.body
		response = unless body == "" do
			body |> JSX.decode!([{:labels, :atom}]) |> wrap_response
		else
			nil
		end

		case status_code do
			x when x < 300 -> response
			x when x < 400 -> :redirected
			_ -> raise_error(status_code, response)
		end
	end

	defp raise_error(status_code, %{message: message}) do
		raise Tagplay.RequestError, status_code: status_code, message: message
	end
	defp raise_error(status_code, message) do
		raise Tagplay.RequestError, status_code: status_code, message: message
	end

	defp wrap_response(%{data: list}=response) when is_list(list) do
		Map.merge(%Tagplay.ListResponse{}, response)
	end
	defp wrap_response(%{data: _}=response), do: response.data
	defp wrap_response(response), do: response

	def delete(url, body \\ "", client), do: _request(:delete, url, client, body)
	def post(url, body \\ "", client), do: _request(:post, url, client, body)
	def patch(url, body \\ "", client), do: _request(:patch, url, client, body)
	def put(url, body \\ "", client), do: _request(:put, url, client, body)
	def get(url, params \\ [], client) do
		url = <<url :: binary, build_qs(params) :: binary>>
		_request(:get, url, client)
	end

	def _request(method, url, client, body \\ "") do
		options = [sslopts: [verify: :verify_none]]
		json_request(method, url, body, authorization_header(client.token), options)
	end

	def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
		request!(method, url, JSX.encode!(body), headers, options) |> process_response
	end

	def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
		request!(method, url, body, headers, options) |> process_response
	end

	@spec build_qs([{atom, binary}]) :: binary
	defp build_qs([]), do: ""
	defp build_qs(kvs), do: to_string('?' ++ URI.encode_query(kvs))

	defp authorization_header(nil) do
		@default_headers
	end
	defp authorization_header(token) do
		@default_headers ++ [{"Authorization", "Bearer #{token}"}]
	end

end
