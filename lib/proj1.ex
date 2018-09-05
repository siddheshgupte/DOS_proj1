defmodule Proj1 do
  @moduledoc """
  Documentation for Proj1.
  """

  use Task

  def start_task(n, k) do
    # Number of chunks given to each Task
    num_of_divisions = 3

    # List of ranges passed to each task (length of list_of_ranges == number of tasks)
    # chunk the input into number of ranges required (n//num_of_divisions)
    list_of_ranges =
      Range.new(1, n)
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

  def process_range(lst, k) do
    # new_list = 
    # lst
    # |> Enum.map(fn x -> :math.pow(2, x) end)
    # |> Enum.sum

    # IO.puts("The sum of 2^x is #{inspect(new_list)}")

    # sum_of_k_numbers = 
    for ele <- lst do
      sq_rt =
        ele
        |> Range.new(ele + k - 1)
        |> Enum.to_list()
        |> Enum.map(fn x -> :math.pow(x, 2) end)
        |> Enum.sum()
        |> :math.sqrt()

      if sq_rt - trunc(sq_rt) == 0 do
        IO.puts("#{ele}, #{sq_rt}")
      end

      # range_ele = Enum.to_list(Range.new(ele, ele + k-1))
    end
  end
end
