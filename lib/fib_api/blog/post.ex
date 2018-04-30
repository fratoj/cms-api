defmodule FibApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :is_published, :boolean, default: false
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :is_published])
    |> validate_required([:title, :is_published])
  end
end
