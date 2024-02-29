defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Repo
  alias Discuss.Schemas.Topic

  require Logger

  def index(conn, params) do
    Logger.debug(IO.inspect(params))

    topics = Topic.list_topic()

    render conn, :index, topics: topics
  end

  def new(conn, params) do
    Logger.debug(IO.inspect(params))

    changeset = Topic.changeset(%Topic{}, %{})

    render conn, :new, changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    topic = Topic.get_topic(id)

    render(conn, "show.html", topic: topic)
  end



  def create(conn, %{"topic" => topic } = _params) do

      changeset = Topic.changeset(%Topic{}, topic)
      Logger.debug(IO.inspect(changeset))

      case Repo.insert(changeset) do
        {:ok, post} ->
          IO.inspect(post)
          conn
          |> put_flash(:info, "#{post.title} created!")
          |> redirect(to: ~p"/topics")

        {:error, changeset} ->
          render conn, :new, changeset: changeset
      end

  end
end
