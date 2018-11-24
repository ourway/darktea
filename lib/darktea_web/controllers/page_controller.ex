defmodule DarkteaWeb.PageController do
  use DarkteaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
