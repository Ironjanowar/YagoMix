MIX_ENV?=dev

deps:
	mix deps.get
	mix deps.compile
compile: deps
	mix compile

token:
export BOT_TOKEN = $(shell cat bot.token)
export CLIENT_TOKEN = $(shell cat client.token)

start: token
	_build/dev/rel/yago_mix/bin/yago_mix start

iex: token
	iex -S mix

clean:
	rm -rf _build

purge: clean
	rm -rf deps
	rm mix.lock

stop:
	_build/dev/rel/yago_mix/bin/yago_mix stop

attach:
	_build/dev/rel/yago_mix/bin/yago_mix attach

release: deps compile
	mix release

debug: token
	_build/dev/rel/yago_mix/bin/yago_mix console

error_logs:
	tail -n 20 -f _build/dev/rel/yago_mix/log/error.log

debug_logs:
	tail -n 20 -f _build/dev/rel/yago_mix/log/debug.log

.PHONY: deps compile release start clean purge token iex stop attach debug
