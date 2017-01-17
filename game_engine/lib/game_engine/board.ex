defmodule GameEngine.Board do
  defstruct data: [nil, nil]

  @shapes [:rock, :paper, :scisors]

  def put(board, :player_one, shape) when shape in @shapes do
        data = List.replace_at(board.data, 0, shape)
        {:ok, %GameEngine.Board{board | data: data}}
  end

  def put(board, :player_two, shape) when shape in @shapes do
        data = List.replace_at(board.data, 1, shape)
        {:ok, %GameEngine.Board{board | data: data}}
  end

  def get_winner(%GameEngine.Board{data: data}) do
    check_winner(data)
  end

  defp check_winner([:rock, :paper]) do
    :player_two
  end
  defp check_winner([:rock, :scisors]) do
    :player_one
  end
  defp check_winner([:rock, :rock]) do
    :tie_games
  end
  defp check_winner([:paper, :paper]) do
    :tie_games
  end
  defp check_winner([:paper, :scisors]) do
    :player_two
  end
  defp check_winner([:paper, :rock]) do
    :player_one
  end
  defp check_winner([:scisors, :paper]) do
    :player_one
  end
  defp check_winner([:scisors, :scisors]) do
    :tie_games
  end
  defp check_winner([:scisors, :rock]) do
    :player_two
  end
end
