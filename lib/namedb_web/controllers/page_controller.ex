defmodule NamedbWeb.PageController do
  use NamedbWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:body_template, "landing")
    |> render("index.html")
  end
end
