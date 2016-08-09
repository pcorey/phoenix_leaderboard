defmodule PhoenixLeaderboard.PlayersChannel do
  use Phoenix.Channel
  alias PhoenixLeaderboard.Repo
  alias PhoenixLeaderboard.Player

  def join("players", _message, socket) do
    {:ok, Repo.all(Player), socket}
  end

  defp handle_player_update({:ok, player}, socket) do
    broadcast! socket, "add_points", %{id: player.id, score: player.score}
    {:noreply, socket}
  end

  defp handle_player_update({:error, changeset}, socket) do
    {:reply, {:error, changeset}, socket}
  end

  def handle_in("add_points", %{"id" => id}, socket) do
    player = Repo.get!(Player, id)
    Player.changeset(player, %{score: player.score + 5})
    |> Repo.update
    |> handle_player_update(socket)
  end
end
