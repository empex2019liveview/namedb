defmodule NamedbWeb.PageController do
  use NamedbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
