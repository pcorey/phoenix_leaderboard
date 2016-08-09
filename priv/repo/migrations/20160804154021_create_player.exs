defmodule PhoenixLeaderboard.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :score, :integer

      timestamps
    end

  end
end
