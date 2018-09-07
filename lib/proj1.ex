defmodule Proj1 do
  @moduledoc """
  Documentation for Proj1.
  """

  use Task

  # Function takes n and k and divides the input amongst machines
  def driver(n, k) do
    # Divide n according to the number of machines
    start_index_1 = 1
    end_index_1 = Kernel.trunc(n / 2)
    start_index_2 = end_index_1 + 1
    end_index_2 = n
    # IO.inspect("#{start_index_1},#{end_index_1},#{start_index_2},#{end_index_2}")

    Node.spawn_link(:"machine2@192.168.0.7", Proj1, :start_task, [start_index_1, end_index_1, k])

    start_task(start_index_2, end_index_2, k)
  end

  def start_task(start_index, n, k) do
    # possible_number_of_tasks =
    #   1..n
    #     |> Enum.to_list()
    #     |> Enum.filter(fn x -> rem(n, x) == 0 end)
    #     |> IO.inspect

    ## Number of chunks given to each Task
    num_of_divisions = 4
    # possible_number_of_tasks
    # |> Enum.at(div(length(possible_number_of_tasks), 2)) 

    # List of ranges passed to each task (length of list_of_ranges == number of tasks)
    # chunk the input into number of ranges required (n//num_of_divisions)
    list_of_ranges =
      Range.new(start_index, n)
      |> Enum.to_list()
      |> Enum.chunk_every(div(n, num_of_divisions))

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
end
