#!/bin/bash
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/${PID}/environ | cut -d= -f2-)

for p in $PID
do
    export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/${p}/environ | cut -d= -f2-)
    if [ ! -z $DBUS_SESSION_BUS_ADDRESS ]
    then
    GNOMEPID=$p
        break
    fi
done

echo
echo $(date)
echo "Session=" $DBUS_SESSION_BUS_ADDRESS

CLIFFS="file:///home/iago/Pictures/Dynamic Wallpapers/Cliffs/"
SIERRA="file:///home/iago/Pictures/Dynamic Wallpapers/Sierra/"
BEACH="file:///home/iago/Pictures/Dynamic Wallpapers/Beach/"
DESERT="file:///home/iago/Pictures/Dynamic Wallpapers/Desert/"
LAKE="file:///home/iago/Pictures/Dynamic Wallpapers/Lake/"
HOUR=$(date +%H)
DAY=$(date +%d)
WPP_TIER=""


case "$DAY" in
01|02|03|04|05|06)
echo "Using Cliffs tier"
WPP_TIER=$CLIFFS
;;
07|08|09)
echo "Using Beachs tier"
WPP_TIER=$BEACH
;;
10|11|12|13)
echo "Using Desert tier"
WPP_TIER=$DESERT
;;
14|15|16|17|18|19)
echo "Using Lake tier"
WPP_TIER=$LAKE
;;
*)
echo "Using Sierra tier"
WPP_TIER=$SIERRA
;;
esac


set_wallpaper(){

    case "$HOUR" in
    03|04|05)
    echo "Setting wallpaper for dawn"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}1.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    06|07)
    echo "Setting wallpaper for almost morning"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}2.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    08|09|10)
    echo "Setting wallpaper for morning"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}3.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    11|12|13)
    echo "Setting wallpaper for noon"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}4.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    14|15)
    echo "Setting wallpaper for almost evening"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}5.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    16|17)
    echo "Setting wallpaper for evening"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}6.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    18|19)
    echo "Setting wallpaper for almost night"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}7.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    *)
    echo "Setting wallpaper for night"
    echo "================================"
    gsettings set org.gnome.desktop.background picture-uri "${WPP_TIER}8.jpg"
    gsettings set org.gnome.desktop.background picture-options 'zoom'
    ;;
    esac
    echo
}

set_wallpaper

