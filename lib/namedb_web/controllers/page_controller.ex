defmodule NamedbWeb.PageController do
  use NamedbWeb, :controller
  import Phoenix.LiveView.Controller, only: [live_render: 3]

  def index(conn, _params) do
    conn
    |> assign(:body_template, "landing")
    |> live_render(NamedbWeb.PageLiveView, session: %{})
  end
end
