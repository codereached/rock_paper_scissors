# Would you like to play a game?
Building a simple elixir game engine

### 1. Creating a project
The game engine will need a game server to supervise each of the games. Elixir has an OTP concept of supervisors to handle this. OTP (the Open Telecom Platform) is a platform with libraries that Erlang provides. It with modules and standards for building your applications.

You can create an OTP skeleton by passing in the option "--sup" when creating your new elixir projects.
mix new game_engine --sup


### 2. Create a game class module with GenServer
We will use a GenServer module for the Game.  GenServer will help create and manage your processes. The game contains a struct to help maintain that status of the game including the current players and how many times each has won.

### 3. Create a board struct for storing your the status of the current game board.
The game board will store the state of the board. It will also hold the logic to determine if the board has a winner. I use a game board to create a standard pattern that can be used with other games.

### 4. Keeping track of processes
When creating a game server it can be difficult to keep track of all the games. One option is using ETS to store your games. ETS is an in-memory table that can be used. Another option that seems to be used more often for simplicity is gproc. gproc will create and manage an ETS table for you.

It has a concept of a via tuple to create a unique id. :n is a unique name and :l is the local node
{:via, :gproc, {:n, :l, {:game, name}}}

Once this is tone you can easily find it with the where-is_name method of gproc.
:gproc.whereis_name({:n, :l, {:game, name}})

### 5. Running in IEX
You can test this by running in IEX.

1. Start iex with your mix project

        iex -S mix

2. Create a game server

        {:ok, pid} = GameEngine.Game.start_link("test_game")

3. Add a players

        GameEngine.Game.join(pid, “test_player_1")
        GameEngine.Game.join(pid, “test_player_2")

4. Players choose shapes

        GameEngine.Game.choose_shape(pid, "test_player_1", "rock")
        GameEngine.Game.choose_shape(pid, "test_player_2", "paper")

5. Check the game to see who is the winner

        GameEngine.Game.check(pid)


#### Helpful Links
[Elixir-lang: Keywords and maps](http://elixir-lang.org/getting-started/keywords-and-maps.html)

[Elixir-lang: Supervisors and Applications](http://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html)

[Elixir-lang: GenServer](http://elixir-lang.org/getting-started/mix-otp/genserver.html)

[Hex: Using Hex](https://hex.pm/docs/usag)

[Hex: Mix Tasks](https://hexdocs.pm/mix/Mix.Tasks.New.html)

[Hex: GenServer Start Task](https://hexdocs.pm/elixir/GenServer.html#start_link/3)

[Hex: Supervisor Spec](https://hexdocs.pm/elixir/Supervisor.Spec.html)

[Hex: IEx](https://hexdocs.pm/iex/IEx.html#summary)

[gproc: Code on Githup](https://github.com/uwiger/gproc)

[gproc: Where is name](https://github.com/uwiger/gproc/blob/master/doc/gproc.md#whereis_name-1)

[stackoverflow: Notes on gproc / ETS](http://stackoverflow.com/questions/25173736/online-users-storing-elixir)

[Erlang: ETS](http://erlang.org/doc/man/ets.html)

[Elixir School: OTP](https://elixirschool.com/lessons/advanced/otp-supervisors/)
