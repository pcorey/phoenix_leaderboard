defmodule PhoenixLeaderboard.PlayerTest do
  use PhoenixLeaderboard.ModelCase

  alias PhoenixLeaderboard.Player

  @valid_attrs %{name: "some content", score: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Player.changeset(%Player{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Player.changeset(%Player{}, @invalid_attrs)
    refute changeset.valid?
  end
end
