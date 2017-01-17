defmodule GameEngine.Game do
  use GenServer

  @initial_score %{player_one: 0, player_two: 0, tie_games: 0}

  defstruct(
    board: %GameEngine.Board{},
    player_one: nil,
    player_two: nil,
    turn: :player_one,
    score: @initial_score
  )

  @doc """
  Starts a game.
  """
  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(name))
  end

  @doc """
  Looks up PID based on name
  """
  def whereis(name) do
    :gproc.whereis_name({:n, :l, {:game, name}})
  end

  defp via_tuple(name) do
    {:via, :gproc, {:n, :l, {:game, name}}}
  end

  def join(game, player) do
    GenServer.call(game, {:join, player})
  end

  def check(game) do
    GenServer.call(game, {:check})
  end

  def choose_shape(game, player, shape) do
    GenServer.call(game, {:choose_shape, player, shape})
  end

  def handle_call({:join, player}, _form, %{player_one: nil} = state) do
    new_state = %{state | player_one: player}
    {:reply, {:ok, :player_one, new_state}, new_state}
  end



  def handle_call({:join, player}, _form, %{player_two: nil} = state) do
    new_state = %{state | player_two: player}
    {:reply, {:ok, :player_two, new_state}, new_state}
  end

  def handle_call({:join, _}, _form, state) do
    {:reply, {:error, "no more players allowed."}, state}
  end

  def handle_call({:choose_shape, player, shape}, _from, %{player_one: player} = state) do
    {:ok, board} = GameEngine.Board.put(state.board, :player_one, String.to_atom(shape))
    new_state = %{state | board: board}
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:choose_shape, player, shape}, _from, %{player_two: player} = state) do
    {:ok, board} = GameEngine.Board.put(state.board, :player_two, String.to_atom(shape))
    new_state = %{state | board: board}
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:check}, _from, state) do
    winner = GameEngine.Board.get_winner(state.board)
    score = Map.update!(state.score, winner, &(&1 + 1))
    new_state = %{state | score: score}
    {:reply, {:winner, winner, new_state}, new_state}
  end


  def init(_) do
    {:ok, %GameEngine.Game{}}
  end
end
