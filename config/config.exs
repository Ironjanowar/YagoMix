# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_gram,
  token: {:system, "BOT_TOKEN"}

config :yago_mix,
  client_token: {:system, "CLIENT_TOKEN"},
  admins: []

config :logger,
  level: :debug,
  truncate: :infinity,
  backends: [{LoggerFileBackend, :debug}, {LoggerFileBackend, :error}]

config :logger, :debug,
  path: "log/debug.log",
  level: :debug,
  format: "$dateT$timeZ [$level] $message\n"

config :logger, :error,
  path: "log/error.log",
  level: :error,
  format: "$dateT$timeZ [$level] $message\n"

config :yago_mix, YagoMix.Scheduler,
  timezone: "Europe/Madrid",
  jobs: [
    {"0 9 * * *", {YagoMix.Cron, :send_spam, []}}
  ]
