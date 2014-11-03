#!/usr/bin/env python
#-*- coding: utf-8 -*-

import json
import sys
import time
from oslo.config import cfg
from common_func import request_info

port2_opts = []
port3_opts = []

port2_opts.append(cfg.StrOpt('port', default=[], help='OpenFlow Port'))
port2_opts.append(cfg.StrOpt('macaddress', default=[], help='MacAddress'))
port2_opts.append(cfg.StrOpt('ipaddress', default=[], help='IpAddress'))
port2_opts.append(cfg.StrOpt('opposite_ipaddress', default=[],
                   help='opposite_IpAddress'))
port3_opts.append(cfg.StrOpt('port', default=[], help='OpenFlow Port'))
port3_opts.append(cfg.StrOpt('macaddress', default=[], help='MacAddress'))
port3_opts.append(cfg.StrOpt('ipaddress', default=[], help='IpAddress'))
port3_opts.append(cfg.StrOpt('opposite_ipaddress', default=[],
                   help='opposite_IpAddress'))


CONF = cfg.CONF
CONF.register_cli_opts(port2_opts, 'Port2')
CONF.register_cli_opts(port3_opts, 'Port3')


##################
# create_interface
##################

def start_create_interface(dpid, port, macaddress, ipaddress, opposite_ipaddress):
    operation = "create_interface"
    url_path = "/openflow/" + dpid + "/interface"
    method = "POST"
    request = '''
{
"interface": {
"port": "%s",
"macaddress": "%s",
"ipaddress": "%s",
"opposite_ipaddress": "%s"
}
}'''% (port, macaddress, ipaddress, opposite_ipaddress)

    interface_result = request_info(operation, url_path, method, request)
    print "----------"
    print json.dumps(interface_result, sort_keys=False, indent=4)
    print ""


##############
# main
##############

def main():
    dpid = "0000000000000001"
    try:
        CONF(default_config_files=['OpenFlow.ini'])
        port2 = CONF.Port2.port
        macaddress2 = CONF.Port2.macaddress
        ipaddress2 = CONF.Port2.ipaddress
        opposite_ipaddress2 = CONF.Port2.opposite_ipaddress
    except cfg.ConfigFilesNotFoundError:
        print "Error: Not Found <OpenFlow.ini> "

    start_create_interface(dpid, port2, macaddress2, ipaddress2,
                           opposite_ipaddress2)

    time.sleep(5)
    try:
        CONF(default_config_files=['OpenFlow.ini'])
        port3 = CONF.Port3.port
        macaddress3 = CONF.Port3.macaddress
        ipaddress3 = CONF.Port3.ipaddress
        opposite_ipaddress3 = CONF.Port3.opposite_ipaddress
    except cfg.ConfigFilesNotFoundError:
        print "Error: Not Found <OpenFlow.ini> "

    start_create_interface(dpid, port3, macaddress3, ipaddress3,
                           opposite_ipaddress3)

if __name__ == "__main__":
    main()
