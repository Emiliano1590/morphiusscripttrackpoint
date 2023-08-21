#!/bin/bash
#

function echo_red()
{
echo -e "\E[0;31m$1"
echo -e '\e[0m'
}

function echo_green()
{
echo -e "\E[0;32m$1"
echo -e '\e[0m'
}

function echo_yellow()
{
echo -e "\E[1;33m$1"
echo -e '\e[0m'
}

zen2=('berknip' 'dirinboz' 'ezkinil' 'morphius' 'woomax')

isChromeOS=true

if [ -f /etc/lsb-release ]; then
	cat /etc/lsb-release | grep "Chrome OS" > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		isChromeOS=false
    fi
    cat /etc/lsb-release | grep "neverware" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		isChromeOS=false
    fi
    cat /etc/lsb-release | grep "Chromium OS" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		isChromeOS=false
    fi
else
	isChromeOS=false
fi

if [[ "$isChromeOS" = false ]]; then
	echo_red "This script must run under Chrome OS"
	exit 1
fi

_hwid=$(crossystem hwid | sed 's/ /_/g')
boardName=$(crossystem hwid | sed 's/X86//g' | awk 'NR==1{print $1}' | cut -f 1 -d'-')
device=${boardName,,}

echo "Chromebook ALTOS 'Project Campfire' EFI / Windows installer"
echo "(C) 2022, CoolStar. All Rights Reserved"

if [ $(whoami) != "root" ]; then
	echo_red "This script must run as root"
	exit 1
fi

case "${_hwid}" in
    ACER_ZGB*)              _x='PNV|Acer AC700 Chromebook' ;;
    AKALI*)                 _x='KBL|Acer Chromebook 13 / Spin 13' ; device="nami";;
    AKEMI*)                 _x='CML|Lenovo Ideapad Flex 5 Chromebook' ;;
    ALEENA*)                _x='STR|Acer Chromebook 315' ;;
    AMPTON*)                _x='GLK|Asus Chromebook Flip C214' ;;
    APEL*)                  _x='GLK|Asus Chromebook Flip C204' ;;
    ARCADA*)                _x='WHL|Dell Latitude 5300' ; device="sarien";;
    ASTRONAUT*)             _x='APL|Acer Chromebook 11 (C732*)' ;;
    ASUKA*)                 _x='SKL|Dell Chromebook 13 (3380)' ;;
    ATLAS*)                 _x='KBL|Google Pixelbook Go' ;;
    AURON_PAINE*)           _x='BDW|Acer Chromebook 11 (C740)' ;;
    AURON_YUNA*)            _x='BDW|Acer Chromebook 15 (CB5-571, C910)' ;;
    BABYMEGA*)              _x='APL|Asus Chromebook C223NA' ;;
    BABYTIGER*)             _x='APL|Asus Chromebook C523NA' ;;
    BANJO*)                 _x='BYT|Acer Chromebook 15 (CB3-531)' ;;
    BANON*)                 _x='BSW|Acer Chromebook 15 (CB3-532)' ;;
    BARD*)                  _x='KBL|Acer Chromebook 715 (CB715)' ; device="nami";;
    BARLA*)                 _x='STR|HP Chromebook 11A G6 EE' ;;
    BERKNIP*)               _x='ZEN2|HP Pro c645 Chromebook Enterprise' ;;
    BLACKTIP*)              _x='APL|White Label Chrombook' ;;
    BLEEMO*)                _x='KBL|Asus Chromebox 3 / CN65 (Core i7)' ; device="fizz";;
    BLIPPER*)               _x='JSL|Lenovo 3i-15 Chromebook	';;
    BLOOGLET*)              _x='GLK|HP Chromebook 14a';;
    BLOOGUARD*)             _x='GLK|HP Chromebook x360 14b';;
    BLOOG*)                 _x='GLK|HP Chromebook x360 12b';;
    BLORB*)                 _x='GLK|Acer Chromebook 315';;
    BLUEBIRD*)              _x='GLK|Samsung Chromebook 4' ;;
    BOBBA360*)              _x='GLK|Acer Chromebook Spin 511' ;;
    BOBBA*)                 _x='GLK|Acer Chromebook 311' ;;
    BOTENFLEX*)             _x='JSL|Lenovo Flex 3i/3i-11 Chromebook' ;;
    BOTEN*)                 _x='JSL|Lenovo 500e Chromebook 2nd Gen' ;;
    BUDDY*)                 _x='BDW|Acer Chromebase 24' ;;
    BUTTERFLY*)             _x='SNB|HP Pavilion Chromebook 14' ;;
    CANDY*)                 _x='BYT|Dell Chromebook 11' ;;
    CAREENA*)               _x='STR|HP Chromebook 14' ;;
    CAROLINE*)              _x='SKL|Samsung Chromebook Pro' ;;
    CASTA*)                 _x='GLK|Samsung Chromebook 4+';;
    CAVE*)                  _x='SKL|ASUS Chromebook Flip C302' ;;
    CELES*)                 _x='BSW|Samsung Chromebook 3' ;;
    CHELL*)                 _x='SKL|HP Chromebook 13 G1' ;;
    CLAPPER*)               _x='BYT|Lenovo N20/N20P Chromebook' ;;
    COPANO*)                _x='TGL|Asus xxx Chromebook' ;;
    CYAN*)                  _x='BSW|Acer Chromebook R11 (C738T)' ;;
    DELBIN*)                _x='TGL|ASUS Chromebook Flip CX5' ;;
    DIRINBOZ*)              _x='ZEN2|HP Chromebook 14a' ;;
    DRAGONAIR*)             _x='CML|HP Chromebook x360 14c' ;;
    DRALLION*)              _x='CML|Dell Latitude 7410 Chromebook Enterprise' ;;
    DRATINI*)               _x='CML|HP Pro c640 Chromebook' ;;
    DRAWCIA*)               _x='JSL|HP Chromebook x360 11 G4 EE' ;;
    DRAWLAT*)               _x='JSL|HP Chromebook 11 G9 EE' ;;
    DRAWMAN*)               _x='JSL|HP Chromebook 14 G7' ;;
    DROBIT*)                _x='TGL|ASUS Chromebook CX9400' ;;
    DROID*)                 _x='GLK|Acer Chromebook 314';;
    DUFFY*)                 _x='CML|ASUS Chromebox 4' ;;
    EDGAR*)                 _x='BSW|Acer Chromebook 14 (CB3-431)' ;;
    EKKO*)                  _x='KBL|Acer Chromebook 714 (CB714)' ; device="nami";;
    ELDRID*)                _x='TGL|HP Chromebook x360 14c' ;;
    ELECTRO*)               _x='APL|Acer Chromebook Spin 11 (R751T)' ;;
    ELEMI*)                 _x='TGL|HP Pro c640 G2 Chromebook' ;;
    ENGUARDE_???-???-??A*)  _x='BYT|CTL N6 Education Chromebook' ;;
    ENGUARDE_???-???-??B*)  _x='BYT|M&A Chromebook' ;;
    ENGUARDE_???-???-??C*)  _x='BYT|Senkatel C1101 Chromebook' ;;
    ENGUARDE_???-???-??D*)  _x='BYT|Edxis Education Chromebook' ;;
    ENGUARDE_???-???-??E*)  _x='BYT|Lenovo N21 Chromebook' ;;
    ENGUARDE_???-???-??F*)  _x='BYT|RGS Education Chromebook' ;;
    ENGUARDE_???-???-??G*)  _x='BYT|Crambo Chromebook' ;;
    ENGUARDE_???-???-??H*)  _x='BYT|True IDC Chromebook' ;;
    ENGUARDE_???-???-??I*)  _x='BYT|Videonet Chromebook' ;;
    ENGUARDE_???-???-??J*)  _x='BYT|eduGear Chromebook R' ;;
    ENGUARDE_???-???-??K*)  _x='BYT|ASI Chromebook' ;;
    ENGUARDE*)              _x='BYT|(multiple device matches)' ;;
    EPAULETTE*)             _x='APL|UNK Acer Chromebook ' ;;
    EVE*)                   _x='KBL|Google Pixelbook' ;;
    EZKINIL*)               _x='ZEN2|Acer Chromebook Spin 514' ;;
    FAFFY*)                 _x='CML|ASUS Fanless Chromebox' ;;
    FALCO*)                 _x='HSW|HP Chromebook 14' ;;
    FIZZ)                   _x='KBL|TBD KBL Chromebox' ;;
    FLEEX*)                 _x='GLK|Dell Chromebook 3100';;
    GALITH*)                _x='JSL|ASUS Chromebook CX1500CKA' ;;
    GALLOP*)                _x='JSL|ASUS Chromebook CX1700CKA' ;;
    GANDOF*)                _x='BDW|Toshiba Chromebook 2 (2015) CB30/CB35' ;;
    GLIMMER*)               _x='BYT|Lenovo ThinkPad 11e/Yoga Chromebook' ;;
    GLK360*)                _x='GLK|Acer Chromebook Spin 311';;
    GLK*)                   _x='GLK|Acer Chromebook 311';;
    GNAWTY*)                _x='BYT|Acer Chromebook 11 (CB3-111/131,C730/C730E/C735)' ;;
    GRABBITER*)             _x='GLK|Dell Chromebook 3100 2-in-1';;
    GUADO*)                 _x='BDW|ASUS Chromebox 2 / CN62' ;;
    HELIOS*)                _x='CML|ASUS Chromebook Flip C436FA' ;;
    HELI*)                  _x='BYT|Haier Chromebook G2' ;;
    IEC_MARIO)              _x='PNV|Google Cr-48' ;;
    JAX*)                   _x='KBL|AOpen Chromebox Commercial 2' ; device="fizz";;
    JINLON*)                _x='CML|HP Elite c1030 Chromebook / HP Chromebook x360 13c';;
    KAISA*)                 _x='CML|Acer Chromebox CXI4' ;;
    KARMA*)                 _x='KBL|Acer Chromebase 24I2' ;;
    KASUMI*)                _x='STR|Acer Chromebook 311' ; device="kasumi";;
    KEFKA*)                 _x='BSW|Dell Chromebook 11 (3180,3189)' ;;
    KENCH*)                 _x='KBL|HP Chromebox G2' ; device="fizz";;
    KINDRED*)               _x='CML|Acer Chromebook 712 (C871)' ;;
    KIP*)                   _x='BYT|HP Chromebook 11 G3/G4, 14 G4' ;;
    KLED*)                  _x='CML|Acer Chromebook Spin 713 (CP713-2W)' ;;
    KOHAKU*)                _x='CML|Samsung Galaxy Chromebook' ;;
    KRACKO-WPBT*)           _x='JSL|CTL Chromebook NL72' ;;
    KRACKO360-BLXA*)        _x='JSL|CTL Chromebook NL72T' ;;
    KRACKO360*)             _x='JSL|LG Chromebook 11TC50Q/11TQ50Q' ;;
    LANTIS-MEXL*)           _x='JSL|HP Chromebook 14a' ;;
    LARS_???-???-???-?3?*)  _x='SKL|Acer Chromebook 11 (C771, C771T)' ;;
    LARS*)                  _x='SKL|Acer Chromebook 14 for Work' ;;
    LASER14*)               _x='GLK|Lenovo Chromebook S340';;
    LASER*)                 _x='GLK|Lenovo Chromebook C340';;
    LAVA*)                  _x='APL|Acer Chromebook Spin 11 CP311' ;;
    LEONA*)                 _x='KBL|Asus Chromebook C425TA' ; device="rammus";;
    LEON*)                  _x='HSW|Toshiba CB30/CB35 Chromebook' ;;
    LIARA*)                 _x='STR|Lenovo 14e Chromebook' ;;
    LIBREM_13_V1)           _x='BDW|Purism Librem 13 v1' ; device="librem13v1";;
    LIBREM13V1)             _x='BDW|Purism Librem 13 v1' ;;
    LIBREM_13_V2)           _x='SKL|Purism Librem 13 v2' ; device="librem13v2";;
    LIBREM13V2)             _x='SKL|Purism Librem 13 v2' ;;
    LIBREM_13_V3)           _x='SKL|Purism Librem 13 v3' ; device="librem13v2";;
    LIBREM13V3)             _x='SKL|Purism Librem 13 v3' ;;
    LIBREM_13_V4)           _x='KBL|Purism Librem 13 v4' ; device="librem13v4";;
    LIBREM13V4)             _x='KBL|Purism Librem 13 v4' ;;
    LIBREM_14)              _x='CML|Purism Librem 14' ; device="librem_14";;
    LIBREM_15_V2)           _x='BDW|Purism Librem 15 v2' ; device="librem15v2";;
    LIBREM15V2)             _x='BDW|Purism Librem 15 v2' ;;
    LIBREM_15_V3)           _x='SKL|Purism Librem 15 v3' ; device="librem15v3";;
    LIBREM15V3)             _x='SKL|Purism Librem 15 v3' ;;
    LIBREM_15_V4)           _x='KBL|Purism Librem 15 v4' ; device="librem15v4";;
    LIBREM15V4)             _x='KBL|Purism Librem 15 v4' ;;
    LIBREM_MINI)            _x='WHL|Purism Librem Mini' ; device="librem_mini";;
    LIBREM_MINI_V2)         _x='CML|Purism Librem Mini v2' ; device="librem_mini_v2";;
    LICK*)                  _x='GLK|Lenovo Ideapad 3 Chromebook' ;;
    LILIPUP*)               _x='TGL|Lenovo IdeaPad Flex 5i Chromebook' ;;
	LINDAR-EDFZ*)           _x='TGL|Lenovo 5i-14 Chromebook' ;;
	LINDAR-LCDF*)           _x='TGL|Lenovo Slim 5 Chromebook' ;;
    LINK*)                  _x='IVB|Google Chromebook Pixel 2013' ;;
    LULU*)                  _x='BDW|Dell Chromebook 13 (7310)' ;;
    MAGPIE*)                _x='JSL|Acer Chromebook 317 [CB317-1H]' ;;
    LUMPY*)                 _x='SNB|Samsung Chromebook Series 5 550' ;;
    MCCLOUD*)               _x='HSW|Acer Chromebox CXI' ;;
    MEEP*)                  _x='GLK|HP Chromebook x360 11 G2 EE' ;;
    MIMROCK*)               _x='GLK|HP Chromebook 11 G7 EE' ;;
    MONROE*)                _x='HSW|LG Chromebase' ;;
    MORPHIUS*)              _x='ZEN2|Lenovo ThinkPad C13 Yoga Chromebook' ;;
    NAUTILUS*)              _x='KBL|Samsung Chromebook Plus V2' ;;
    NASHER360*)             _x='APL|Dell Chromebook 11 2-in-1 5190' ;;
    NASHER*)                _x='APL|Dell Chromebook 11 5190' ;;
    NIGHTFURY*)             _x='CML|Samsung Galaxy Chromebook 2' ;;
    NINJA*)                 _x='BYT|AOpen Chromebox Commercial' ;;
    NOCTURNE*)              _x='KBL|Google Pixel Slate' ;;
    NOIBAT*)                _x='CML|HP Chromebox G3' ;;
    ORCO*)                  _x='BYT|Lenovo Ideapad 100S Chromebook' ;;
    ORBATRIX*)              _x='GLK|Dell Chromebook 3400';;
    PAINE*)                 _x='BDW|Acer Chromebook 11 (C740)' ; device="auron_paine";;
    PANTHEON*)              _x='KBL|Lenovo Yoga Chromebook C630'  ; device="nami";;
    PANTHER*)               _x='HSW|ASUS Chromebox CN60' ;;
    PARROT*)                _x='SNB|Acer C7/C710 Chromebook' ;;
    PEPPY*)                 _x='HSW|Acer C720/C720P Chromebook' ;;
    PHASER360S*)            _x='GLK|Lenovo 500e Chromebook 2nd Gen' ;;
    PHASER360*)             _x='GLK|Lenovo 300e Chromebook 2nd Gen' ;;
    PHASER*)                _x='GLK|Lenovo 100e Chromebook 2nd Gen' ;;
    PYRO*)                  _x='APL|Lenovo Thinkpad 11e/Yoga Chromebook (G4)' ;;
    QUAWKS*)                _x='BYT|ASUS Chromebook C300' ;;
    RABBID*)                _x='APL|ASUS Chromebook C423' ;;
    RAMMUS*)                _x='KBL|Asus Chromebook C425/C433/C434' ;;
    REEF_???-C*)            _x='APL|ASUS Chromebook C213NA' ;;
    REEF*)                  _x='APL|Acer Chromebook Spin 11 (R751T)' ; device="electro";;
    REKS_???-???-???-B*)    _x='BSW|2016|Lenovo N42 Chromebook' ;;
    REKS_???-???-???-C*)    _x='BSW|2017|Lenovo N23 Chromebook (Touch)';;
    REKS_???-???-???-D*)    _x='BSW|2017|Lenovo N23 Chromebook' ;;
    REKS_???-???-???-*)     _x='BSW|2016|Lenovo N22 Chromebook' ;;
    REKS*)                  _x='BSW|2016|(unknown REKS)' ;;
    RELM_???-B*)            _x='BSW|CTL NL61 Chromebook' ;;
    RELM_???-C*)            _x='BSW|Edxis Education Chromebook' ;;
    RELM_???-F*)            _x='BSW|Mecer V2 Chromebook' ;;
    RELM_???-G*)            _x='BSW|HP Chromebook 11 G5 EE' ;;
    RELM_???-H*)            _x='BSW|Acer Chromebook 11 N7 (C731)' ;;
    RELM_???-Z*)            _x='BSW|Quanta OEM Chromebook' ;;
    RELM*)                  _x='BSW|(unknown RELM)' ;;
    RIKKU*)                 _x='BDW|Acer Chromebox CXI2' ;;
    ROBO360*)               _x='APL|Lenovo 500e Chromebook' ;;
    ROBO*)                  _x='APL|Lenovo 100e Chromebook' ;;
    SAMUS*)                 _x='BDW|Google Chromebook Pixel 2015' ;;
    SAND*)                  _x='APL|Acer Chromebook 15 (CB515-1HT)' ;;
    SANTA*)                 _x='APL|Acer Chromebook 11 (CB311-8H)' ;;
    SARIEN*)                _x='WHL|Dell Latitude 5400' ;;
    SASUKE*)                _x='JSL|Samsung Galaxy Chromebook Go' ;;
    SENTRY*)                _x='SKL|Lenovo Thinkpad 13 Chromebook' ;;
    SETZER*)                _x='BSW|HP Chromebook 11 G5' ;;
    SHYVANA*)               _x='KBL|Asus Chromebook Flip C433/C434' ; device="rammus";;
    SION*)                  _x='KBL|Acer Chromebox CXI3' ; device="fizz";;
    SNAPPY_???-A*)          _x='APL|HP Chromebook x360 11 G1 EE' ;;
    SNAPPY_???-B*)          _x='APL|HP Chromebook 11 G6 EE' ;;
    SNAPPY_???-C*)          _x='APL|HP Chromebook 14 G5' ;;
    SNAPPY*)                _x='APL|HP Chromebook x360 11 G1/11 G6/14 G5' ;;
    SPARKY*)                _x='GLK|Acer Chromebook 512 (C851/C851T)' ;;
    SONA*)                  _x='KBL|HP Chromebook x360 14' ; device="nami";;
    SORAKA*)                _x='KBL|HP Chromebook x2' ;;
    SQUAWKS*)               _x='BYT|ASUS Chromebook C200' ;;
    STORO360*)              _x='JSL|ASUS Chromebook CR1100CKA' ;;
    STORO*)                 _x='JSL|ASUS Chromebook Flip CR1100FKA' ;;
    STOUT*)                 _x='IVB|Lenovo Thinkpad X131e Chromebook' ;;
    STUMPY*)                _x='SNB|Samsung Chromebox Series 3' ;;
    SUMO*)                  _x='BYT|AOpen Chromebase Commercial' ;;
    SWANKY*)                _x='BYT|Toshiba Chromebook 2 (2014) CB30/CB35' ;;
    SYNDRA*)                _x='KBL|HP Chromebook 15 G1' ; device="nami";;
    TEEMO*)                 _x='KBL|Asus Chromebox 3 / CN65' ; device="fizz";;
    TERRA_???-???-???-A*)   _x='BSW|ASUS Chromebook C202SA' ;;
    TERRA_???-???-???-B*)   _x='BSW|ASUS Chromebook C300SA/C301SA' ;;
    TERRA*)                 _x='BSW|ASUS Chromebook C202SA, C300SA/C301SA' ; device="terra";;
    TIDUS*)                 _x='BDW|Lenovo ThinkCentre Chromebox' ;;
    TREEYA360*)             _x='STR|Lenovo 300e Chromebook 2nd Gen AMD' ; device="treeya";;
    TREEYA*)                _x='STR|Lenovo 100e Chromebook 2nd Gen AMD' ; device="treeya";;
    TRICKY*)                _x='HSW|Dell Chromebox 3010' ;;
    ULTIMA*)                _x='BSW|Lenovo ThinkPad 11e/Yoga Chromebook (G3)' ;;
    VAYNE*)                 _x='KBL|Dell Inspiron Chromebook 14 (7486)'  ; device="nami";;
    VOLTA*)                 _x='TGL|Acer Chromebook 514 (CB514-1H)' ;;
	VORTICON*)              _x='GLK|HP Chromebook 11 G8 EE' ;;
	VORTININJA*)            _x='GLK|HP Chromebook x360 11 G3 EE' ;;
    VOXEL*)                 _x='TGL|Acer Chromebook Spin 713 (CP713-3W)' ;;
    WHITETIP*)              _x='APL|CTL Chromebook J41/J41T' ;;
    WINKY*)                 _x='BYT|Samsung Chromebook 2 (XE500C12)' ;;
    WIZPIG_???-???-??A*)    _x='BSW|CTL Chromebook J5' ;;
    WIZPIG_???-???-??B*)    _x='BSW|Edugear CMT Chromebook' ;;
    WIZPIG_???-???-??C*)    _x='BSW|Haier Convertible Chromebook 11 C' ;;
    WIZPIG_???-???-??D*)    _x='BSW|Viglen Chromebook 360' ;;
    WIZPIG_???-???-??G*)    _x='BSW|Prowise ProLine Chromebook' ;;
    WIZPIG_???-???-??H*)    _x='BSW|PCMerge Chromebook PCM-116T-432B' ;;
    WIZPIG_???-???-??I*)    _x='BSW|Multilaser M11C Chromebook' ;;
    WIZPIG*)                _x='BSW|(unknown WIZPIG)' ;;
    WOLF*)                  _x='HSW|Dell Chromebook 11' ;;
    WOOMAX*)                _x='ZEN2|ASUS Chromebook Flip CM5' ;;
    WUKONG_???-???-???-??C*) _x='KBL|ViewSonic NMP660 Chromebox' ; device="fizz";;
    WUKONG*)                _x='KBL|CTL Chromebox CBx1' ; device="fizz";;
    WYVERN*)                _x='CML|CTL Chromebox CBx2' ;;
    YUNA*)                  _x='BDW|Acer Chromebook 15 (CB5-571, C910)' ; device="auron_yuna";;
    ZAKO*)                  _x='HSW|HP Chromebox CB1' ;;
esac

deviceCpuType=$(echo $_x | cut -d\| -f1)
deviceDesc=$(echo $_x | cut -d\| -f2-)

## CPU family, Processor core, other distinguishing characteristic
case "$deviceCpuType" in
ARM) deviceCpuType="ARM" ;;
PNV) deviceCpuType="Intel Pineview" ;;
SNB) deviceCpuType="Intel SandyBridge" ;;
IVB) deviceCpuType="Intel IvyBridge" ;;
HSW) deviceCpuType="Intel Haswell" ;;
BYT) deviceCpuType="Intel BayTrail" ;;
BDW) deviceCpuType="Intel Broadwell" ;;
BSW) deviceCpuType="Intel Braswell" ;;
SKL) deviceCpuType="Intel Skylake" ;;
APL) deviceCpuType="Intel ApolloLake" ;;
KBL) deviceCpuType="Intel KabyLake" ;;
GLK) deviceCpuType="Intel GeminiLake" ;;
STR) deviceCpuType="AMD StoneyRidge" ;;
WHL) deviceCpuType="Intel WhiskeyLake" ;;
CML) deviceCpuType="Intel CometLake" ;;
ZEN2) deviceCpuType="AMD Zen2/Picasso" ;;
JSL) deviceCpuType="Intel JasperLake" ;;
TGL) deviceCpuType="Intel TigerLake" ;;
*)   deviceCpuType="(unrecognized)" ;;
esac

echo "Device: ${deviceDesc} (${boardName^^})"
echo "Platform: $deviceCpuType"

[[ "${zen2[@]}" =~ "$device" ]] && isZen2=true

if [[ "$isZen2" = false ]]; then
	echo_red "This script only supports AMD Zen2 Chromebooks"
	exit 1
fi

drive=""

if [ -b /dev/nvme0n1 ]; then
	echo "Detected NVMe SSD"
	drive="/dev/nvme0n1"
elif [ -b /dev/mmcblk0 ]; then
	echo "Detected eMMC"
	echo_red "UEFI only supports NVMe SSDs currently"
	drive="/dev/mmcblk0"
	exit 1
elif [ -b /dev/mmcblk1 ]; then
    echo "Detected eMMC"
    echo_red "UEFI only supports NVMe SSDs currently"
    drive="/dev/mmcblk1"
    exit 1
else
	echo "Unknown storage (maybe SATA???)"
	echo_red "UEFI only supports NVMe SSDs currently"
	drive="/dev/sda"
	exit 1
fi

if [[ $boardName != 'BERKNIP' && $boardName != 'MORPHIUS' && $boardName != 'WOOMAX' ]]; then
    echo "Warning: Only Berknip, Morphius and Woomax have been validated. Other chromebooks may work, but compatibility is not guaranteed."
fi

isElanPad=true
isSynapticsPad=false
isRaydiumTouch=false
isElanTouch=false
isElanHIDTouch=false
isG2Touch=false
isGdixTouch=true

for dev in /sys/class/i2c-adapter/*/i2c-*/; do
	devname="$(basename -- $dev)"
	if [[ $devname = "i2c-dev" ]]; then
		continue
	fi
	if [[ $devname = "i2c-ELAN0000:"* ]]; then
		isElanPad=true
		echo "Found Elan Touchpad"
	fi

	if [[ $devname = "i2c-PNP0C50:"* ]]; then
		isSynapticsPad=true
		echo "Found Synaptics Touchpad"
	fi

	if [[ $devname = "i2c-RAYD0001:"* ]]; then
		isRaydiumTouch=true
		echo "Found Raydium Touch Screen"
	fi

	if [[ $devname = "i2c-ELAN0001:"* ]]; then
		isElanTouch=true
		echo "Found Elan Touch Screen"
	fi

    if [[ $devname = "i2c-ELAN9008:"* ]]; then
        isElanHIDTouch=true
        echo "Found Elan HID Touch Screen"
    fi

	if [[ $devname = "i2c-GTCH7503:"* ]]; then
		isG2Touch=true
		echo "Found G2 Touch Screen"
	fi

    if [[ $devname = "i2c-GDIX0000:"* ]]; then
        isGdixTouch=true
        echo "Found GDIX Touch Screen"
    fi
done

driveSize=$(fdisk -s "${drive}p7")
if ((driveSize < 12582912)); then
	echo_red "Your Windows paritition is less than 12 GB. Please run chrx once (do not run it a second time) to allocate enough space."

	echo "Paritition details:"
	fdisk -l "${drive}p7"
	exit 1
fi

echo ""
echo_red "VERY IMPORTANT:"
echo "It is also recommended to use the firmware utility script from mrchromebox.tech to update the AltOS Tianocore payload (the stock one works except with broken keyboard)"
echo "You must also use the graphical boot selector (rEFInd) to boot Windows, either from internal or external drives."
echo "Booting directly from Tianocore is not supported as OpenCore is used to load the patches"
echo "For working sleep/wake in Windows you must install the CR50 TPM driver. Follow the post-install guide on CoolStar's website for details."

echo ""

echo "Details of your Windows partition size (ROOT-C):"
fdisk -l "${drive}p7"

echo ""

echo_yellow "If you still wish to continue, type 'I UNDERSTAND' and press enter"

read -e
if [[ "$REPLY" != "I UNDERSTAND" ]]; then
	echo_red "User did not confirm. Exiting"
	exit 1
fi

echo "Setting ROOT-C partition label to 'Windows'"
sfdisk --part-label "${drive}" 7 Windows

echo "Setting Windows partition as MS Basic Data"
sfdisk --part-type "${drive}" 7 ebd0a0a2-b9e5-4433-87c0-68b6b72699c7

echo "Setting KERN-C partition to MS Reserved"
sfdisk --part-type "${drive}" 6 e3c9e316-0b5c-4db8-817d-f92df00215ae

echo_yellow "It is recommended to format the Windows partition as NTFS to make it easier to select in the installer."
echo_red "If you are updating an existing Windows install, do not reformat unless you want to reinstall Windows."
echo "Do you wish to format as NTFS?"

REPLY=""
while [[ "$REPLY" != "N" && "$REPLY" != "n" && "$REPLY" != "Y" && "$REPLY" != "y"  ]]
do
	read -ep "Enter 'y' or 'n'"
	if [[ "$REPLY" = "Y" || "$REPLY" = "y" ]]; then
		echo "Formatting as NTFS"
		mkfs.ntfs -f "${drive}p7"
	else
		echo "Not formatting"
	fi
done

echo "Mounting EFI paritition"
mkdir -p /tmp/efi
mount "${drive}p12" /tmp/efi

set -e

if [ ! -d /tmp/efi/efi/boot-chromeos ]; then
	echo_green "Backing up Chrome OS GRUB loader"
	mv /tmp/efi/efi/boot /tmp/efi/efi/boot-chromeos
fi

echo "Clearing any existing EFI bootloader"
rm -rf /tmp/efi/efi/boot
rm -rf /tmp/efi/efi/OC
rm -rf /tmp/efi/efi/refind

echo "Downloading OpenCore + rEFInd"
curl -L -O https://coolstar.org/chromebook/windows-rwl/opencore-refind-rwl-generic.tar.gz
mkdir -p /tmp/efi/efi/boot

echo_green "Installing OpenCore + rEFInd"
tar xf opencore-refind-rwl-generic.tar.gz -C /tmp/efi/efi/boot 
mv /tmp/efi/efi/boot/OC /tmp/efi/efi/OC
mv /tmp/efi/efi/boot/refind /tmp/efi/efi/refind

echo "Downloading Tools.."
curl -L -O https://coolstar.org/chromebook/windows-rwl/iasl.gz
curl -L -O https://coolstar.org/chromebook/windows-rwl/patch.gz

gzip -d iasl.gz
gzip -d patch.gz

rm -rf /usr/local/bin/iasl /usr/local/bin/patch
mkdir -p /usr/local/bin
mv iasl /usr/local/bin/
mv patch /usr/local/bin
chmod +x /usr/local/bin/iasl
chmod +x /usr/local/bin/patch

echo "Dumping System ACPI tables"
mkdir -p /tmp/fwpatch
cat /sys/firmware/acpi/tables/DSDT > /tmp/fwpatch/dsdt.aml

if grep -q COREBOOT /sys/firmware/acpi/tables/SSDT1; then
    echo "Found COREBOOT SSDT1"
    cat /sys/firmware/acpi/tables/SSDT1 > /tmp/fwpatch/ssdt.aml
fi

if grep -q COREBOOT /sys/firmware/acpi/tables/SSDT2; then
    echo "Found COREBOOT SSDT2"
    cat /sys/firmware/acpi/tables/SSDT2 > /tmp/fwpatch/ssdt.aml
fi

echo "Disassembling ACPI tables"
iasl -d /tmp/fwpatch/dsdt.aml /tmp/fwpatch/ssdt.aml

echo "Downloading Patches"
curl -L -O https://coolstar.org/chromebook/windows-rwl/acpipatches.tar.gz
tar xf acpipatches.tar.gz -C /tmp/fwpatch

if $(true); then
    echo "Applying Patches"

    pushd /tmp/fwpatch #Enter Firmware patch stage

    echo "Applying DSDT Patch (Zen2 Chrome EC BSOD Fix)"
    patch -s -F 3 -i patches/zen2-crec-fix.patch dsdt.dsl

    echo "Applying DSDT Patch (Zen2 GPIO Fix)"
    patch -s -F 3 -i patches/zen2-gpio.patch dsdt.dsl

    echo "Applying DSDT Patch (Zen2 UART Fix)"
    patch -s -F 3 -i patches/zen2-uart.patch dsdt.dsl

    echo "Applying DSDT Patch (Zen2 Remove MISC)"
    patch -s -F 3 -i patches/zen2-nomisc.patch dsdt.dsl

    echo "Applying DSDT Patch (Zen2 Remove AAHB)"
    patch -s -F 3 -i patches/zen2-noaahb.patch dsdt.dsl
    
    if grep -q GOOG0002 dsdt.dsl; then
        echo "Applying DSDT Patch (Zen2 Keyboard Backlight)"
        patch -s -F 3 -i patches/zen2-kblt-scope.patch dsdt.dsl
    fi

    if grep -q GOOG0015 dsdt.dsl; then
        echo "Applying DSDT Patch (Morphius No Trackpoint)"
        
    fi

    if grep -q GOOG0006 dsdt.dsl; then
        echo "Applying DSDT Patch (Zen2 Tablet Mode)"
        patch -s -F 5 -i patches/zen2-tabletmode.patch dsdt.dsl
    fi

    if grep -q DPTC ssdt.dsl; then
        echo "Applying SSDT Patch (Syntax Fix)"
        patch -s -F 3 -i patches/morphius-syntax-fix.patch ssdt.dsl
    fi

    if grep -q RTD2141B ssdt.dsl; then
        echo "Applying SSDT Patch (Remove MST HUB)"
        patch -s -F 3 -i patches/nomst.patch ssdt.dsl
    fi

    if grep -q AMDI5682 ssdt.dsl; then
        echo "Applying SSDT Patch (Remove AMDI5682)"
        patch -s -F 5 -i patches/zen2-nomach.patch ssdt.dsl
    fi

    if grep -q AMDI1015 ssdt.dsl; then
        echo "Applying SSDT Patch (Remove AMDI1015)"
        patch -s -F 5 -i patches/zen2-nomach1015.patch ssdt.dsl
    fi

    if grep -q "Fingerprint Reader" ssdt.dsl; then
        echo "Applying SSDT Patch (Fingerprint Fix)"
        patch -s -F 3 -i patches/fingerprintfix.patch ssdt.dsl
    fi

    if grep -q ELAN0000 ssdt.dsl; then
        if [ "$isElanPad" = true ]; then
            echo "Applying SSDT Patch (Elan Touchpad)"
            patch -s -F 3 -i patches/elantp.patch ssdt.dsl
        else
            echo "Applying SSDT Patch (No Elan Touchpad)"
            patch -s -F 3 -i patches/noelantp.patch ssdt.dsl
        fi
    fi

    if grep -q "Synaptics Touchpad" ssdt.dsl; then
        if [ "$isSynapticsPad" = true ]; then
            echo "Applying SSDT Patch (Synaptics Touchpad)"
            patch -s -F 3 -i patches/synatp.patch ssdt.dsl
        else
            echo "Applying SSDT Patch (No Synaptics Touchpad)"
            patch -s -F 3 -i patches/nosynatp.patch ssdt.dsl
        fi
    fi

    if grep -q RAYD0001 ssdt.dsl; then
        if [ "$isRaydiumTouch" = true ]; then
            echoerr "Warning: Raydium Touchscreen is currently unsupported"
        fi
        echo "Applying SSDT Patch (No Raydium Touchscreen)"
        patch -s -F 3 -i patches/noraydiumts.patch ssdt.dsl
    fi

    if grep -q ELAN0001 ssdt.dsl; then
        if [ "$isElanTouch" = true ]; then
            echo "Applying SSDT Patch (Elan Touchscreen)"
            patch -s -F 3 -i patches/elants.patch ssdt.dsl
        else
            echo "Applying SSDT Patch (No Elan Touchscreen)"
            patch -s -F 3 -i patches/noelants.patch ssdt.dsl
        fi
    fi

    if grep -q ELAN9008 ssdt.dsl; then
        if [ "$isElanHIDTouch" = true ]; then
            echo "No Patch required (Elan HID Touchscreen)"
        else
            echo "Applying SSDT Patch (No Elan HID Touchscreen)"
            patch -s -F 6 -i patches/noelan9008ts.patch ssdt.dsl
        fi
    fi

    if grep -q GTCH7503 ssdt.dsl; then
        if [ "$isG2Touch" = true ]; then
            echo "No Patch required (G2 Touchscreen)"
        else
            echo "Applying SSDT Patch (No G2 Touchscreen)"
            patch -s -F 3 -i patches/nog2touch.patch ssdt.dsl
        fi
    fi

    if grep -q GDIX0000 ssdt.dsl; then
        if [ "$isGdixTouch" = true ]; then
            echo "No Patch required (GDIX Touchscreen)"
        else
            echo "Applying SSDT Patch (No GDIX Touchscreen)"
            patch -s -F 3 -i patches/nogdixts.patch ssdt.dsl
        fi
    fi

    if grep -q 10EC1015 ssdt.dsl; then
        echo "Applying SSDT Patch (Vilboz Duplicate I2C)"
        patch -s -F 5 -i patches/vilboz-nodupi2c.patch ssdt.dsl
        sed -i 's/TUN1/TUN0/g' ssdt.dsl
    fi

    popd
fi

echo "Compiling ACPI tables"
mv /tmp/fwpatch/dsdt.dsl /tmp/fwpatch/dsdt-modified.dsl
mv /tmp/fwpatch/ssdt.dsl /tmp/fwpatch/ssdt1-modified.dsl
iasl -ve /tmp/fwpatch/dsdt-modified.dsl
iasl -ve /tmp/fwpatch/ssdt1-modified.dsl

echo "Installing patched tables"
mv /tmp/fwpatch/dsdt-modified.aml /tmp/efi/efi/OC/ACPI/
mv /tmp/fwpatch/ssdt1-modified.aml /tmp/efi/efi/OC/ACPI/

echo "Unmounting EFI partition"
umount /tmp/efi

echo_green "Cleaning Up..."
rm -rf opencore-refind-rwl-generic.tar.gz iasl.gz patch.gz acpipatches.tar.gz
rm -rf /usr/local/bin/iasl /usr/local/bin/patch /tmp/fwpatch

echo_green "Done. Reboot and press Ctrl + L (or select Alternate OS) to install/boot Windows"