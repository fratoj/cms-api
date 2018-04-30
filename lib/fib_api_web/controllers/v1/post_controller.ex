defmodule FibApiWeb.V1.PostController do
  use FibApiWeb, :controller

  alias FibApi.Blog
  alias FibApi.Repo
  alias FibApi.Blog.Post

  action_fallback(FibApiWeb.FallbackController)

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json-api", data: posts)
  end

  def create(conn, %{"data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Post.changeset(%Post{}, attrs)

    case Repo.insert(changeset) do
      {:ok, article} ->
        conn
        |> put_status(201)
        |> render("show.json-api", data: article)

      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end

  # def create(conn, %{"post" => post_params}) do
  #   with {:ok, %Post{} = post} <- Blog.create_post(post_params) do
  #     conn
  #     |> put_status(:created)
  #     |> render("show.json", post: post)
  #   end
  # end

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
