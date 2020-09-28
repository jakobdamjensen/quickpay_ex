defmodule Quickpay.Client do
  @moduledoc """
    Struct which represents QuickPay client
  """

  alias __MODULE__, as: Client

  defstruct [:api_key, :host]

  def new(api_key) do
    %Client{
      api_key: api_key,
      host: "https://api.quickpay.net/"
    }
  end

  @doc """
  Convert map to json string
  """
  def to_json!(map) do
    json_library().encode!(map)
  end

  @doc """
  Convert string to map
  """
  def from_json!(string) do
    json_library().decode!(string)
  end

  def put!(url, headers, body \\ ""), do: HTTPoison.put!(url, body, default_headers(headers))
  def post!(url, headers, body \\ ""), do: HTTPoison.post!(url, body, default_headers(headers))

  def get!(url, headers), do: HTTPoison.get!(url, default_headers(headers))
  def delete!(url, headers), do: HTTPoison.delete!(url, default_headers(headers))

  def patch!(url, headers, body), do: HTTPoison.patch!(url, body, default_headers(headers))

  defp json_library do
    Application.get_env(QuickPay.Client, :json_library) || Jason
  end

  defp default_headers(extra_headers) when is_nil(extra_headers) do
    default_headers([])
  end

  defp default_headers(extra_headers) when is_list(extra_headers) do
    [
      {"Accept-Version", "v10"},
      {"Accept", "application/json"},
      {"User-Agent", "quickpay_ex, v1.0.0"},
      {"Content-Type", "application/json"}
    ] ++ extra_headers
  end

  def authorization_header(%Client{api_key: api_key}) do
    {"Authorization", "Basic #{Base.encode64(":" <> api_key)}"}
  end
end
