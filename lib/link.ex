defmodule Quickpay.Link do
  defstruct [
    # url	Url to payment window for this payment link	string
    url: nil,
    # raw response
    raw: nil
  ]

  def from_json(json) do
    Quickpay.StructUtils.to_struct(__MODULE__, json)
  end
end
