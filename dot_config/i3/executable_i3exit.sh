#!/bin/sh
#systemd

lock() {
    i3lock -e -t -i ~/config/.i3/background.png
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Hibernate.Suspend" boolean:true
        ;;
    hibernate)
        lock && dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Hibernate" boolean:true
        ;;
    reboot)
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" boolean:true
        ;;
    shutdown)
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true
        ;;
    *)
        echo "Usage: $0 {lock|reboot|shutdown}"
        exit 2
esac

exit 0
