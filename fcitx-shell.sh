#!/bin/sh
if [ `fcitx-remote` = 1 ]; then
		echo 'A'
	else
		echo 'mozc'
fi
