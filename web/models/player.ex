defmodule PhoenixLeaderboard.Player do
  use PhoenixLeaderboard.Web, :model
  @derive { Poison.Encoder, only: [:id, :name, :score] }

  schema "players" do
    field :name, :string
    field :score, :integer

    timestamps
  end

  @required_fields ~w(name score)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
