defmodule Quickpay.StructUtils do
  def to_struct(struct_module, attrs) do
    struct = struct(struct_module)

    Enum.reduce(Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(attrs, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end)
    |> Map.put(:raw, attrs)
  end

  def convert_fields_to_datetime(
        struct,
        keys \\ [:created_at, :updated_at, :retented_at, :deadline_at]
      ) do
    Enum.reduce(keys, struct, fn key, sub ->
      case Map.get(sub, key) do
        nil ->
          sub

        date ->
          case DateTime.from_iso8601(date) do
            {:ok, datetime, _} ->
              sub
              |> Map.put(key, datetime)

            _ ->
              sub
          end
      end
    end)
  end

  def convert_http_response_to_struct(res, status_code_to_accept, struct_module) do
    case res do
      %HTTPoison.Response{body: body, status_code: ^status_code_to_accept} ->
        Quickpay.Client.from_json!(body)
        |> struct_module.from_json()

      %HTTPoison.Response{body: body} ->
        Quickpay.Client.from_json!(body)
    end
  end
end
