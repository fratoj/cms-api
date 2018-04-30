defmodule FibApiWeb.V1.PostController do
  use FibApiWeb, :controller
  # require Logger
  alias FibApi.Blog
  alias FibApi.Blog.Post

  action_fallback(FibApiWeb.FallbackController)

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json-api", data: posts)
  end

  def create(conn, %{"data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)

    case Blog.create_post(attrs) do
      {:ok, post} ->
        conn
        |> put_status(201)
        |> render("show.json-api", data: post)

      {:error, attrs} ->
        conn
        |> put_status(422)
        |> render(:errors, data: attrs)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.json-api", data: post)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    post = Blog.get_post!(id)
    # Logger.debug("data: #{inspect(data)}")

    attrs = JaSerializer.Params.to_attributes(data)
    # Logger.debug("attrs: #{inspect(attrs)}")

    case Blog.update_post(post, attrs) do
      {:ok, post} ->
        conn
        |> put_status(201)
        |> render("show.json-api", data: post)

      {:error, attrs} ->
        conn
        |> put_status(422)
        |> render(:errors, data: attrs)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
