defmodule YagoMixTest do
  use ExUnit.Case
  doctest YagoMix

  test "greets the world" do
    assert YagoMix.hello() == :world
  end
end
