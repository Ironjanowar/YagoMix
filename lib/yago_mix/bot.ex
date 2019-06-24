defmodule YagoMix.Bot do
  @bot :yago_mix

  use ExGram.Bot,
    name: @bot

  require Logger

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, "pachangueo", _msg}, context) do
    {:ok, track} = YagoMix.Server.get_random_track()
    %{message: message, markup: markup} = YagoMix.MessageFormatter.format_track(track)
    answer(context, message, reply_markup: markup, parse_mode: "Markdown")
  end

  def handle({:command, "yagomax", %{chat: %{id: cid}}}, context) do
    YagoMix.Cron.add_sub(cid)

    answer(
      context,
      "Preparate para conocer la auténtica salud!\nCada día te enviaré un temaso para que muevas tu cuerpo serrano."
    )
  end

  def handle({:command, "yagomin", %{chat: %{id: cid}}}, _context) do
    YagoMix.Cron.del_sub(cid)

    ExGram.send_photo(
      cid,
      "https://img.buzzfeed.com/buzzfeed-static/static/2016-03/16/18/enhanced/webdr07/original-7224-1458166152-4.jpg",
      caption: "Parece que alguien no soporta la fiesta."
    )
  end
end
