# Original work
https://github.com/shimizukawa/docker-td-agent

# Docker td-agent on CentOS 7

This is a CentOS7-based Docker image with:

- [td-agent](http://www.fluentd.org/)
- fluent-plugin-elasticsearch
- fluent-plugin-record-modifier
- fluent-plugin-exclude-filter

which does nothing by default.

Either the packaged `fluent.conf` or the one within a mounted volume is used.

`-v /path/to/fluentdconfdir:/etc/fluentd`


# Simple usage

`docker run -d -v /path/to/fluentdconfdir:/etc/fluentd chrisx86/td-agent

# settings

PATH

- `/etc/fluentd/fluent.conf`: td-agent config file
- `/var/log/td-agent/`: td-agent log directory

default fluent.conf

- see: [fluent.conf](https://github.com/chris-x86-64/docker-td-agent/blob/master/etc/fluentd/fluent.conf)

