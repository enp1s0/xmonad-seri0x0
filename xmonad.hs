import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doRectFloat)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.WindowProperties (Property (..), propertyToQuery)
import XMonad.Util.EZConfig
import System.IO

main = do
    xmproc <- spawnPipe "xmobar /home/mutsuki/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { terminal    = "alacritty"
        , modMask     = mod4Mask
        , borderWidth = 3
        , normalBorderColor = "#11103B"
        , focusedBorderColor = "#D4D4D6"
        , startupHook = spawn "feh --bg-scale ~/images/xmonad.jpg"
        , manageHook = myManageHook
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
        , handleEventHook = docksEventHook
        } `additionalKeys` myAdditionalKeys

myManageHook = composeAll
    [ propertyToQuery (Role "GtkFileChooserDialog")
        --> doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)
    ]
    <+>
    manageDocks
    <+>
    manageHook defaultConfig

myAdditionalKeys = [
    ((mod4Mask .|. shiftMask, xK_w), spawn "chromium"),
    ((mod4Mask .|. shiftMask, xK_f), spawn "firefox"),
    ((mod4Mask .|. shiftMask, xK_s), spawn "slack"),
    ((mod4Mask .|. shiftMask, xK_n), spawn "simplenote")
    ]
