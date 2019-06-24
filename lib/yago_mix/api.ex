defmodule YagoMix.Api do
  use Tesla

  plug(Tesla.Middleware.FormUrlencoded)

  def client(client_token) do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "https://accounts.spotify.com"},
      {Tesla.Middleware.Headers, [{"Authorization", "Basic #{client_token}"}]}
    ]

    Tesla.client(middlewares)
  end

  def authorized_client(token) do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "https://api.spotify.com/v1"},
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{token}"}]}
    ]

    Tesla.client(middlewares)
  end

  def get_token() do
    client_token = ExGram.Config.get(:yago_mix, :client_token)

    {:ok, %{body: body}} =
      client_token |> client() |> post("/api/token", %{grant_type: "client_credentials"})

    %{"access_token" => token} = Jason.decode!(body)
    {:ok, token}
  end

  def get_random_track(token) do
    {:ok, %{body: body}} =
      token
      |> authorized_client
      |> get("/playlists/14KwHeTVx7af5EEgEOQr8J/tracks", query: [limit: 1])

    %{"total" => total_songs} = Jason.decode!(body)

    offset = Enum.random(1..total_songs)

    {:ok, %{body: body}} =
      token
      |> authorized_client
      |> get("/playlists/14KwHeTVx7af5EEgEOQr8J/tracks", query: [limit: 1, offset: offset])

    %{
      "items" => [
        %{
          "track" => %{
            "artists" => [%{"name" => artist} | _],
            "album" => %{"name" => album_name},
            "name" => song_name,
            "external_urls" => %{"spotify" => href},
            "uri" => uri
          }
        }
        | _
      ]
    } = Jason.decode!(body)

    {:ok,
     %{
       artist: artist,
       album: album_name,
       name: song_name,
       href: href,
       uri: uri
     }}
  end
end
