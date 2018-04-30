defmodule FibApiWeb.V1.PostView do
  use FibApiWeb, :view
  use JaSerializer.PhoenixView

  attributes([:title, :is_published])
end
