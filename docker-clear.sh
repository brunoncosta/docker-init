#!/bin/bash

echo "Cleaning Containers..."
sudo docker rm -f $(sudo docker ps -a -q)
