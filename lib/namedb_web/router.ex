defmodule NamedbWeb.Router do
  use NamedbWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(Namedb.Plugs.CurrentUser)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NamedbWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/logout", PageController, :logout
    get "/account", AccountController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NamedbWeb do
  #   pipe_through :api
  # end
end
