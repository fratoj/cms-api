defmodule FibApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:published, :boolean, default: false)
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :published])
    |> validate_required([:title, :published])
  end
end
