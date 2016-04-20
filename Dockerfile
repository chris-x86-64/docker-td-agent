FROM centos:latest
MAINTAINER Christopher Smith <chris@binc.jp>

# update
RUN yum update -y

# ruby related packages for td-agent
RUN yum install -y make ruby ruby-devel

# install fluentd td-agent
ADD ./install-redhat-td-agent2-sudoless.sh /tmp/td.sh
RUN sh /tmp/td.sh && rm /tmp/td.sh

# clean cache files
RUN yum clean all

# install fluentd plugins
RUN /opt/td-agent/embedded/bin/fluent-gem install --no-ri --no-rdoc \
    fluent-plugin-elasticsearch \
    fluent-plugin-record-modifier \
    fluent-plugin-exclude-filter

# add conf
ADD ./etc/fluentd /etc/fluentd

CMD /opt/td-agent/embedded/bin/fluentd -c /etc/fluentd/fluent.conf
