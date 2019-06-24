defmodule YagoMix.Server do
  def get_random_track() do
    {:ok, token} = YagoMix.Api.get_token()
    token |> YagoMix.Api.get_random_track()
  end
end
