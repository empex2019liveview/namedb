defmodule NamedbWeb.PageLiveView do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div class="hero">
      <h1>nmdb</h1>
      <%= case assigns[:email] do %>
        <% nil -> %>
          <h2>Helping you name things gooder</h2>

          <%= if assigns[:error] do %>
            <div class="error">
              <p>
                How embarassing... but something went really wrong.
                Try again, if you don't mind, and if the problem
                persists then drop up as email.
              </p>
            </div>
          <% end %>

          <form phx-submit="join-mailing-list">
            <input name="email" type="text" placeholder="Email Address" autofocus />
            <button>Subscribe To Weekly Emails</button>
          </form>
        <% email -> %>
          <h2>Thank you for signing up</h2>
          <div class="thank-you">
            <p>
              Just to make sure you are really you, an email has just been
              sent to <span class="email"><%= email %></span> to confirm
              your enrollement in our weekly newsletter.
            </p>
          </div>
      <% end %>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_event("join-mailing-list", %{"email" => email}, socket) do
    email
    |> case do
      "" -> socket
      "badinput" -> socket |> assign(:error, true)
      _ -> socket |> assign(:email, email)
    end
    |> (fn socket -> {:noreply, socket} end).()
  end
end
