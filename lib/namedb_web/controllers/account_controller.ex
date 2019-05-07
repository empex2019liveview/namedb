defmodule NamedbWeb.AccountController do
  use NamedbWeb, :controller

  plug :ensure_user

  def index(conn, _params) do
    conn
    |> assign(:body_template, "account")
    |> render("index.html")
  end

  defp ensure_user(conn, _) do
    if conn.assigns[:user] do
      conn
    else
      conn |> redirect(to: "/") |> halt()
    end
  end
end
