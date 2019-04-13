defmodule NamedbWeb.PageControllerTest do
  use NamedbWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "namedb"
  end
end