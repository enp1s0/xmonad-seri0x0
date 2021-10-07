#!/bin/sh

amixer sget Master | grep 'Mono:' | sed -e 's/.*\[//' -e 's/\]//'
