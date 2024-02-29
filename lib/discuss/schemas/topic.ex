defmodule Discuss.Schemas.Topic do
  alias Discuss.Schemas.Topic
  alias Discuss.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string

  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  def list_topic() do
    Repo.all(Topic)
  end

  def get_topic(id) do
    Repo.get(Topic, id)
  end
end
