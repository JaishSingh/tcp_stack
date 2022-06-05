#!/bin/bash
cargo b --release
sudo setcap cap_net_admin=eip ./target/release/tcpImpl
target/release/tcpImpl &
pid=$!
sudo ip addr add 192.168.0.1/24 dev tun
sudo ip link set up dev tun
trap "kill $pid" INT TERM
wait $pid