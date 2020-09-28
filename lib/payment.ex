defmodule Quickpay.Payment do
  defstruct [
    #id	Id	integer
    id: nil,
    # merchant_id	Merchant id	integer
    merchant_id: nil,
    # order_id	Order number	string
    order_id: nil,
    # accepted	Accepted by acquirer	boolean
    accepted: nil,
    # type	transaction type	string
    type: nil,
    # text_on_statement	Text on statement	string
    text_on_statement: nil,
    # branding_id	Branding id	integer
    branding_id: nil,
    # variables	Custom variables	hash
    variables: nil,
    # currency	Currency	string
    currency: nil,
    # state	State of transaction	string (initial, pending, new, rejected, processed)
    state: nil,
    # metadata	Metadata	Metadata
    metadata: nil,
    # link	PaymentLink	PaymentLink
    link: nil,
    # shipping_address	Shipping address set on payment creation	OptionalAddress
    shipping_address: nil,
    # invoice_address	Invoice address set on payment creation	OptionalAddress
    invoice_address: nil,
    # basket	Order items	Basket
    basket: nil,
    # shipping	Shipping	Shipping
    shipping: nil,
    # operations	Operations	Operation[]
    operations: nil,
    # test_mode	Test mode	boolean
    test_mode: nil,
    # acquirer	Acquirer that processed the transaction	string
    acquirer: nil,
    # facilitator	Facilitator that facilitated the transaction	string
    facilitator: nil,
    # created_at	Timestamp of creation	ISO-8601
    created_at: nil,
    # updated_at	Timestamp of last updated	ISO-8601
    updated_at: nil,
    # retented_at	Timestamp of retention	ISO-8601
    retented_at: nil,
    # balance	Balance	integer
    balance: nil,
    # fee	Fee added to authorization amount (only relevant on auto-fee)	integer
    fee: nil,
    # subscription_id	Parent subscription id (only recurring)	integer
    subscription_id: nil,
    # deadline_at	Authorize deadline	ISO-8601
    deadline_at: nil,
    # raw response
    raw: nil
  ]

  def from_json(json) do
    Quickpay.StructUtils.to_struct(__MODULE__, json)
    |> Quickpay.StructUtils.convert_fields_to_datetime()
  end
end
