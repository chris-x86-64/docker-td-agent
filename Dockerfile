FROM centos:latest
MAINTAINER Christopher Smith <chris@binc.jp>

# update
RUN yum update -y

# ruby related packages for td-agent
RUN yum install -y make ruby ruby-devel net-tools

# install fluentd td-agent
ADD ./install-redhat-td-agent2-sudoless.sh /tmp/td.sh
RUN sh /tmp/td.sh && rm /tmp/td.sh

# clean cache files
RUN yum clean all

# install fluentd plugins
RUN /opt/td-agent/embedded/bin/fluent-gem install --no-ri --no-rdoc \
    fluent-plugin-elasticsearch \
    fluent-plugin-record-modifier \
    fluent-plugin-exclude-filter \
    fluent-plugin-s3 \
    fluent-plugin-forest \
    fluent-plugin-slack

# add conf and dirs
ADD ./etc/fluentd /etc/fluentd
RUN mkdir /srv/td-agent
RUN mkdir -p /var/cache/td-agent/buffers

CMD /opt/td-agent/embedded/bin/fluentd -c /etc/fluentd/fluent.conf
