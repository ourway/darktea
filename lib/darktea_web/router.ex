defmodule DarkteaWeb.Router do
  use DarkteaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DarkteaWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/:page", PageController, :index
    get "/:scope/:page", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DarkteaWeb do
  #   pipe_through :api
  # end
end
