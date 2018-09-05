
# This exs script allows us to call the start_task function from the command line like mix run proj1.exs 3 2 

[arg1, arg2] = Enum.map(System.argv, fn x -> String.to_integer(x) end)
IO.inspect Proj1.start_task(arg1, arg2)