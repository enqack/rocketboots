#!/bin/sh

## initialize local configuration file
git submodule init

## fetch projects and checkout the appropriate commit
git submodule update
