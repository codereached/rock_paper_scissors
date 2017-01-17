defmodule GameEngine.Registry do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def find_game(name) do
    GameEngine.Game.whereis(name)
  end

  def create_game(name) do
    {:ok, pid} = GameEngine.GameSupervisor.start_child(name)
  end

  def init(_) do
    {:ok, nil}
  end
end
