defmodule Namedb.Plugs.CurrentUser do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> lookup_flash()
    |> lookup_session()
    |> store_user()
  end

  defp lookup_session(conn) do
    conn
    |> get_session(:user)
    |> set_if(conn)
  end

  defp lookup_flash(conn) do
    conn
    |> Phoenix.Controller.get_flash(:user)
    |> set_if(conn)
  end

  defp set_if(nil, conn), do: conn

  defp set_if(user, conn) do
    case conn.assigns[:user] do
      nil -> conn |> assign(:user, user)
      _existing -> conn
    end
  end

  defp store_user(conn) do
    case conn.assigns[:user] do
      nil -> conn
      user -> conn |> put_session(:user, user)
    end
  end
end
