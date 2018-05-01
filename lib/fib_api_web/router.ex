defmodule FibApiWeb.Router do
  use FibApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json-api"])
  end

  scope "/api", FibApiWeb do
    pipe_through(:api)

    scope "/v1", V1, as: :v1 do
      resources("/post", PostController)
    end
  end
end
