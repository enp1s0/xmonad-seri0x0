#!/bin/sh

amixer sget Master | grep Mono: | sed -e 's/.*[0-9] \[//' -e 's/\].*//'
