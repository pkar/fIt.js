#!/bin/bash

cp fIt.js fIt.min.js
uglifyjs --overwrite -v fIt.min.js

