# Would you like to play a game?
Building a simple elixir game engine

### 1. Creating a project
The game engine will need a game server to supervise each of the games. Elixir has an OTP concept of supervisors to handle this. OTP (the Open Telecom Platform) is a platform with libraries that Erlang provides. It with modules and standards for building your applications.

You can create an OTP skeleton by passing in the option "--sup" when creating your new elixir projects.
mix new game_engine --sup


### 2. Create a game class module with Genserver
We will use a Genserver module for the Game.  Genserver will help create and manage your processes. The game contains a struct to help maintain that status of the game including the current players and how many times each has won.

### 3. Create a board struct for storing your the status of the current game board.
The game board will store the state of the board. It will also hold the logic to determine if the board has a winner. I use a game board to create a standard pattern that can be used with other games.

### 4. Keeping track of processes
When creating a game server it can be difficult to keep track of all the games. One option is using ETS to store your games. ETS is an in-memory table that can be used. Another option that seems to be used more often for simplicity is gproc. gproc will create and manage an ETS table for you.

It has a concept of a via tuple to create a unique id. :n is a unique name and :l is the local node
{:via, :gproc, {:n, :l, {:game, name}}}

Once this is tone you can easily find it with the where-is_name method of gproc.
:gproc.whereis_name({:n, :l, {:game, name}})
