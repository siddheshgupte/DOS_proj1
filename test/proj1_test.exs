defmodule Proj1Test do
  use ExUnit.Case
  doctest Proj1

  # test "greets the world" do
  #   assert Proj1.hello() == :world
  # end

  # Tests for the format: "#{start_ele}, #{square root}"
  test "Test for trivial" do
    assert Proj1.start_task(3, 2) === "3, 5.0"
  end
end
