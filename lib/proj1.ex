defmodule Proj1 do
  @moduledoc """
  Documentation for Proj1.
  """

  use Task

  # Function takes n and k and divides the input amongst machines
  def driver(n, k) do
    # Divide n according to the number of machines
    if length(Node.list()) > 0 do
      # Divide workload amongst the machines
      chunks_of_workloads =
        1..n
        |> Enum.to_list()
        |> Enum.chunk_every(div(n, length(Node.list()) + 1))

      # Assign all workloads except the last one to connected nodes (from 0 to len(Node.list)-1)
      for x <- Enum.to_list(0..(length(Node.list()) - 1)) do
        Node.spawn_link(Enum.at(Node.list(), x), Proj1, :start_task, [
          Enum.at(chunks_of_workloads, x),
          k
        ])
      end

      # Assign last workload to current node
      start_task(Enum.at(chunks_of_workloads, length(Node.list())), k)
    else
      #  If no other nodes are connected assign the complete workload to current node
      start_task(Enum.to_list(1..n), k)
    end
  end

  def start_task(workload_list, k) do
   
    ## Number of chunks given to each Task
    num_of_divisions = 4
 
    # List of ranges passed to each task (length of list_of_ranges == number of tasks)
    # chunk the input into number of ranges required (n//num_of_divisions)
    list_of_ranges =
      workload_list
      |> Enum.chunk_every(div(length(workload_list), num_of_divisions))

    # Start a new Task for each range
    tasks =
      for x <- list_of_ranges do
        # NOTE: start_link has been used instead of async as we are not using the return value 
        # The arg to start_link has to be the anonymous function not start_link(process_range(x))
        Task.start_link(fn -> process_range(x, k) end)
      end
  end

  # Function to do all the calculations and print the output
  def process_range(lst, k) do
    for ele <- lst do
      # sq_rt = square root of sum of squares of ele to ele + k-1
      sq_rt =
        ele
        |> Range.new(ele + k - 1)
        |> Enum.to_list()
        |> Enum.map(fn x -> :math.pow(x, 2) end)
        |> Enum.sum()
        |> :math.sqrt()

      # Check if perfect square
      if sq_rt - trunc(sq_rt) == 0 do
        IO.puts("#{ele}, #{sq_rt}, #{Node.self()}")
      end
    end
  end

  def find_best_task_division(n) do
    
    # Make a list of the possible number of tasks
    possible_number_of_tasks =
      1..n
        |> Enum.to_list()
        |> Enum.filter(fn x -> rem(n, x) == 0 end)
        |> IO.inspect
      
    # Print the best task division (This should be assigned to num_of_divisions in start_task )
    possible_number_of_tasks
    |> Enum.at(div(length(possible_number_of_tasks), 2))
    |> IO.inspect

  end 
end
