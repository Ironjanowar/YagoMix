defmodule YagoMix.MessageFormatter do
  def format_track(track) do
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

    %{message: message, markup: markup}
  end
end
