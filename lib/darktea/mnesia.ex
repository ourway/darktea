defmodule Darktea.Db.Setup do
  @moduledoc """
  Creates and setups new mnesia database for project.
  """
  require Logger

  # [{:database, [_, {:config, [hosts: nodes]}, _, _, _]}] =
  #  Application.get_env(:libcluster, :topologies)

  # @nodes nodes
  @wait_time 500
  # @data File.read!("/Users/rodmena/Movies/BW-Scroll.mp4") |> Base.encode64

  @spec all_active_nodes() :: list(Atom.t())
  @doc """
    returns all connected nodes
  """
  def all_active_nodes() do
    [node()]
  end

  #

  @spec stop_mnesia() :: :stopping
  def stop_mnesia do
    :stopped = :mnesia.stop()
  end

  @spec start_mnesia() :: :ok
  def start_mnesia do
    :ok = :mnesia.start()
  end

  @spec start_every_mnesia(list(Atom.t())) :: :ok
  def start_every_mnesia(nodes) do
    _ =
      nodes
      |> Enum.map(fn n ->
        :rpc.call(n, __MODULE__, :start_mnesia, [])
      end)

    :ok
  end

  @spec stop_every_mnesia(list(Atom.t())) :: :ok
  def stop_every_mnesia(nodes) do
    _ =
      nodes
      |> Enum.map(fn n ->
        :rpc.call(n, __MODULE__, :stop_mnesia, [])
      end)

    :ok
  end

  @spec delete_schema(list(Atom.t())) :: :ok
  def delete_schema(nodes) do
    stop_every_mnesia(nodes)

    Logger.info(fn -> "stopping nodes ..." end)
    Process.sleep(@wait_time)

    case :mnesia.delete_schema(nodes) do
      :ok ->
        Logger.warn("database schema deleted.")
    end

    start_every_mnesia(nodes)
  end

  @spec create_schema(list(Atom.t())) :: :ok
  def create_schema(nodes) do
    stop_every_mnesia(nodes)
    Logger.info(fn -> "stopping nodes ..." end)
    Process.sleep(@wait_time)

    case :mnesia.create_schema(nodes) do
      :ok ->
        Logger.info(fn -> "database schema created." end)

      {:error, {_, {:already_exists, _}}} ->
        Logger.debug(fn -> "database schema is already created." end)
    end

    start_every_mnesia(nodes)
  end

  @spec insert_test_record() :: {:atomic, :ok}
  def insert_test_record do
    key = :hasan
    value = :rahim

    pck = {KVTb, key, value}

    {:atomic, :ok} =
      :mnesia.transaction(fn ->
        # Logger.debug(fn -> "test record #{idx} is inserting to database" end)
        :ok = :mnesia.write(pck)
      end)
  end

  ############################# SDP TABLES #############################
  @table_config [
    {AuthUserTb, [:idx, :username_idx, :email_idx, :password_hash_idx, :bio, :avatar]},
    {PostTb,
     [
       :idx,
       :author_idx,
       :title,
       :desc,
       :version,
       :elements,
       :status_idx,
       :protection,
       :update_unixtime
     ]},
    {ElementTb, [:idx, :page_idx, :order, :type, :content, :status_idx, :unixtime]},
    {CommentTb, [:idx, :page_idx, :commenter_idx, :body, :status_idx, :unixtime]},
    {LikeTb, [:idx, :target_idx, :unixtime]},
    {FileTb, [:idx, :name, :blob, :desc, :unixtime]},
    {KVTb, [:key, :value]}
  ]

  def create_tables do
    for tdata <- @table_config do
      name = tdata |> elem(0)
      attrs = tdata |> elem(1)
      idxs = attrs |> Enum.filter(fn x -> x |> to_string |> String.ends_with?("_idx") end)

      case :mnesia.create_table(name, [
             {:disc_copies, all_active_nodes()},
             {:type, :ordered_set},
             majority: true,
             attributes: attrs,
             index: idxs
           ]) do
        {:atomic, :ok} ->
          Logger.info(fn -> "#{name} table created." end)

        {:aborted, {:already_exists, name}} ->
          Logger.debug(fn -> "#{name} table is available." end)
      end
    end
  end

  @spec initialize() :: :ok
  def initialize do
    nodes = all_active_nodes()
    create_schema(nodes)
    Logger.info(fn -> "schema created. Loading ..." end)
    Process.sleep(@wait_time)
    # create_tables()
    :ok
  end

  @spec populate_db(list(Atom.t())) :: any()
  def populate_db(nodes) do
    for _ <- 1..1000 do
      :rpc.call(
        nodes |> Enum.shuffle() |> hd,
        DatabaseEngine.Mnesia.DbSetup,
        :insert_test_record,
        []
      )
    end
  end
end
