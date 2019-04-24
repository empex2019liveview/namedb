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
        <% :saving -> %>
          <h2>Processing ... thanks for waiting</h2>
          <svg class="processing" width="120" height="30" viewBox="0 0 120 30" xmlns="http://www.w3.org/2000/svg">
              <circle cx="15" cy="15" r="15">
                  <animate attributeName="r" from="15" to="15"
                           begin="0s" dur="0.8s"
                           values="15;9;15" calcMode="linear"
                           repeatCount="indefinite" />
                  <animate attributeName="fill-opacity" from="1" to="1"
                           begin="0s" dur="0.8s"
                           values="1;.5;1" calcMode="linear"
                           repeatCount="indefinite" />
              </circle>
              <circle cx="60" cy="15" r="9" fill-opacity="0.3">
                  <animate attributeName="r" from="9" to="9"
                           begin="0s" dur="0.8s"
                           values="9;15;9" calcMode="linear"
                           repeatCount="indefinite" />
                  <animate attributeName="fill-opacity" from="0.5" to="0.5"
                           begin="0s" dur="0.8s"
                           values=".5;1;.5" calcMode="linear"
                           repeatCount="indefinite" />
              </circle>
              <circle cx="105" cy="15" r="15">
                  <animate attributeName="r" from="15" to="15"
                           begin="0s" dur="0.8s"
                           values="15;9;15" calcMode="linear"
                           repeatCount="indefinite" />
                  <animate attributeName="fill-opacity" from="1" to="1"
                           begin="0s" dur="0.8s"
                           values="1;.5;1" calcMode="linear"
                           repeatCount="indefinite" />
              </circle>
          </svg>


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
    send(self(), {:store_email, email})
    {:noreply, socket |> assign(:email, :saving)}
  end

  def handle_info({:store_email, email}, socket) do
    email
    |> case do
      "" -> socket
      "badinput" -> socket |> fake_wait(5) |> assign(:email, nil) |> assign(:error, true)
      _ -> socket |> fake_wait(5) |> assign(:email, email)
    end
    |> socket_reply()
  end

  defp fake_wait(input, num_seconds) do
    :timer.sleep(num_seconds * 1000)
    input
  end

  defp socket_reply(socket, reply \\ :noreply), do: {reply, socket}
end
