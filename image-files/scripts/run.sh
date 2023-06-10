#!/bin/sh

export DISPLAY=:1

rm -f /tmp/.X1-lock
Xvfb :1 -ac -screen 0 1024x768x16 &

if [ -n "$VNC_SERVER_PASSWORD" ]; then
  echo "Starting VNC server"
  /root/scripts/run_x11_vnc.sh &
fi

envsubst < "${IBC_INI}.tmpl" > "${IBC_INI}"

# Override IBC_INI with environment variables
./replace.sh ${IBC_INI}

/root/scripts/fork_ports_delayed.sh &

if [[ -z ${TWS_OR_GATEWAY} ]]; then
  gatewayparam = "-g"
else
  gatewayparam = 
fi

/root/ibc/scripts/ibcstart.sh "${TWS_MAJOR_VRSN}" ${gatewayparam} \
     "--tws-path=${TWS_PATH}" \
     "--ibc-path=${IBC_PATH}" "--ibc-ini=${IBC_INI}" \
     "--user=${TWS_USERID}" "--pw=${TWS_PASSWORD}" "--mode=${TRADING_MODE}" \
     "--on2fatimeout=${TWOFA_TIMEOUT_ACTION}"
