# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FibApi.Repo.insert!(%FibApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FibApi.Repo
alias FibApi.Blog.Post

Repo.insert!(%Post{title: "Getting started with Phoenix and JSON API", published: true})
Repo.insert!(%Post{title: "Next steps with Phoenix and JSON API", published: false})
