defmodule FibApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:title, :string)
      add(:published, :boolean, default: false, null: false)

      timestamps()
    end
  end
end
