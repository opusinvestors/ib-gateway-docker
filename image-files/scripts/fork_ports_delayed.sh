#!/bin/sh

sleep 30

intport=${IBC_OverrideTwsApiPort:-4000}
extport = ${TWS_API_PORT:-4001}
if [ "$TRADING_MODE" = "paper" ]; then
  extport=${TWS_API_PORT:-4002}
fi

printf "Forking :::${intport} onto 0.0.0.0:${extport}\n"
socat TCP-LISTEN:${extport},fork TCP:127.0.0.1:${intport}
