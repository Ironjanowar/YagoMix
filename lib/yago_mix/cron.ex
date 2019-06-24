defmodule YagoMix.Cron do
  def send_spam() do
    get_subs()
    |> Enum.each(fn sub ->
      {:ok, track} = YagoMix.Server.get_random_track()
      %{message: message, markup: markup} = YagoMix.MessageFormatter.format_track(track)
      ExGram.send_message(sub, message, reply_markup: markup, parse_mode: "Markdown")
    end)
  end

  def get_subs() do
    case File.read("subs.json") do
      {:ok, subs} -> subs |> Jason.decode!() |> MapSet.new() |> MapSet.to_list()
      _ -> []
    end
  end

  def add_sub(chat_id) do
    subs = [chat_id | get_subs()] |> MapSet.new() |> MapSet.to_list() |> Jason.encode!()
    File.write("subs.json", subs)
  end

  def del_sub(chat_id) do
    subs = get_subs() |> List.delete(chat_id) |> Jason.encode!()
    File.write("subs.json", subs)
  end
end
