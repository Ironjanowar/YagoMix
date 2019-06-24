defmodule YagoMix.Bot do
  @bot :yago_mix

  use ExGram.Bot,
    name: @bot

  require Logger

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, "pachangueo", _msg}, context) do
    {:ok, track} = YagoMix.Server.get_random_track()

    message = """
    🎤 Artist: `#{track[:artist]}`
    🎵 Song: `#{track[:name]}`
    📀 Album: `#{track[:album]}`
    🔗 URI: `#{track[:uri]}`
    """

    markup =
      ExGram.Dsl.create_inline([
        [
          [text: "Open in Spotify", url: track[:href]]
        ]
      ])

    answer(context, message, reply_markup: markup, parse_mode: "Markdown")
  end
end
