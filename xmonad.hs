import Data.Default
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doRectFloat)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.WindowProperties (Property (..), propertyToQuery)
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import System.IO

main = do
    xmproc <- spawnPipe "xmobar /home/mutsuki/.xmonad/xmobarrc"
    xmonad $ docks $ def
        { terminal    = "alacritty"
        , modMask     = mod4Mask
        , borderWidth = 1
        , normalBorderColor = "#11103B"
        , focusedBorderColor = "#D4D4D6"
        , startupHook = spawn "feh --bg-scale ~/images/iceberg.png"
        , manageHook = myManageHook
        , layoutHook = avoidStruts $ layoutHook def
        , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
        } `additionalKeys` myAdditionalKeys

myManageHook = composeAll
    [ propertyToQuery (Role "GtkFileChooserDialog")
        --> doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)
    ]
    <+>
    manageDocks
    <+>
    manageHook def

myAdditionalKeys = [
    ((mod4Mask .|. shiftMask, xK_w), spawn "google-chrome-stable --process-per-site"),
    ((mod4Mask .|. shiftMask, xK_e), spawn "google-chrome-stable --process-per-site --incognito"),
    ((mod4Mask .|. shiftMask, xK_f), spawn "firefox"),
    ((mod4Mask .|. shiftMask, xK_s), spawn "slack"),
    ((mod4Mask .|. shiftMask, xK_d), spawn "dmenu_run -nb \"#002b36\" -nf \"#657b83\" -sb \"#073642\" -sf \"#fdf6e3\" -fn \"-*-terminus-medium-r-normal-*-*-*-*-*-c-*-iso10646-1\""),
    ((mod4Mask .|. shiftMask, xK_t), spawn "urxvt"),
    ((mod4Mask .|. shiftMask, xK_g), spawn "gimp"),
    ((mod4Mask .|. shiftMask, xK_i), spawn "inkscape"),
    ((mod4Mask .|. shiftMask, xK_m), spawn "/usr/local/mendeley/bin/mendeleydesktop"),
    ((mod4Mask .|. shiftMask, xK_n), spawn "simplenote"),
    ((0, xF86XK_MonBrightnessUp)   , spawn "xbacklight -inc 10"),
    ((0, xF86XK_MonBrightnessDown) , spawn "xbacklight -dec 10"),
    ((0, xF86XK_AudioRaiseVolume)  , spawn "amixer sset Master 2+"),
    ((0, xF86XK_AudioLowerVolume)  , spawn "amixer sset Master 2-"),
    ((0, xF86XK_AudioMute) , spawn "amixer sset Master toggle")
    ]
