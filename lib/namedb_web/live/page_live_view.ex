defmodule NamedbWeb.PageLiveView do
  use Phoenix.LiveView

  def render(assigns) do
    NamedbWeb.PageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_event("join-mailing-list", %{"email" => email}, socket) do
    send(self(), {:store_email, email})
    {:noreply, socket |> assign(:email, :saving)}
  end

  def handle_info({:store_email, email}, socket) do
    email
    |> case do
      "" ->
        socket |> socket_reply()

      "badinput" ->
        socket |> fake_wait(5) |> assign(:email, nil) |> assign(:error, true) |> socket_reply()

      _ ->
        socket |> fake_wait(5) |> assign(:email, email) |> socket_reply()
    end
  end

  defp fake_wait(input, num_seconds) do
    :timer.sleep(num_seconds * 1000)
    input
  end

  defp socket_reply(socket, reply \\ :noreply), do: {reply, socket}
end
