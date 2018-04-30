defmodule FibApiWeb.V1.PostController do
  use FibApiWeb, :controller

  alias FibApi.Blog

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

  # def update(conn, %{"id" => id, "post" => post_params}) do
  #   post = Blog.get_post!(id)

  #   with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
  #     render(conn, "show.json", post: post)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   post = Blog.get_post!(id)

  #   with {:ok, %Post{}} <- Blog.delete_post(post) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
