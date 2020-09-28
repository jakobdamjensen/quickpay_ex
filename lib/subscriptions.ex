defmodule Quickpay.Subscriptions do
  alias Quickpay.Client
  alias Quickpay.Subscription

  import Quickpay.Client

  def create(%Client{} = client, order_id, currency, description, options \\ %{})
      when is_binary(order_id) and is_binary(currency) and is_binary(description) do
    post!(
      client.host <> "subscriptions",
      [authorization_header(client)],
      to_json!(
        Map.merge(options, %{
          "order_id" => order_id,
          "currency" => currency,
          "description" => description
        })
      )
    )
    |> Quickpay.StructUtils.convert_http_response_to_struct(201, Subscription)
  end

  def link(%Client{} = client, subscription_id, amount, options \\ %{}) do
    put!(
      "#{client.host}subscriptions/#{subscription_id}/link",
      [authorization_header(client)],
      to_json!(
        Map.merge(options, %{
          "amount" => amount,
          "payment_methods" => "creditcard"
        })
      )
    )
    |> Quickpay.StructUtils.convert_http_response_to_struct(200, Quickpay.Link)
  end

  def get(%Client{} = client, subscription_id) do
    get!(
      "#{client.host}subscriptions/#{subscription_id}",
      [authorization_header(client)]
    )
    |> Quickpay.StructUtils.convert_http_response_to_struct(200, Subscription)
  end

  def recurring(
        %Client{} = client,
        %Subscription{id: subscription_id},
        order_id,
        amount,
        options \\ %{}
      ) do
    post!(
      client.host <> "subscriptions/#{subscription_id}/recurring",
      [authorization_header(client)],
      to_json!(
        Map.merge(options, %{
          "order_id" => order_id,
          "amount" => amount
        })
      )
    )
    |> Quickpay.StructUtils.convert_http_response_to_struct(202, Quickpay.Payment)
  end
end
