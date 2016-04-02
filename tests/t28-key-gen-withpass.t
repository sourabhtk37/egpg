#!/usr/bin/env bash

test_description='Command: key gen'
source "$(dirname "$0")"/setup.sh

test_expect_success 'Make sure `haveged` is started' '
    [[ -n "$(ps ax | grep -v grep | grep haveged)" ]]
'

test_expect_success 'init' '
    egpg_init &&
    setup_autopin &&
    send_gpg_commands_from_stdin
'

test_expect_success 'egpg key gen' '
    echo <<-_EOF | egpg key gen test1@example.org "Test 1" 2>&1 | grep "Excellent! You created a fresh GPG key." &&
123456
123456
_EOF
    [[ $(egpg key | grep uid:) == "uid: Test 1 <test1@example.org>" ]]
'

test_done
