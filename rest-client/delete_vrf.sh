#!/usr/bin/env python
#-*- coding: utf-8 -*-

import json
from oslo_config import cfg
from common_func import request_info

vrf_opts = []

vrf_opts.append(cfg.StrOpt('route_dist', default=[],  help='route_dist'))

CONF = cfg.CONF
CONF.register_cli_opts(vrf_opts, 'Vrf')


##################
# delete_vrf
##################

def start_delete_vrf(dpid, route_dist):
    operation = "delete_vrf"
    url_path = "/openflow/" + dpid + "/vrf"
    method = "DELETE"
    request = '''
{
"vrf": {
"route_dist": "%s"
}
}'''%(route_dist)

    vrf_result = request_info(operation, url_path, method, request)
    print "----------"
    print json.dumps(vrf_result, sort_keys=False, indent=4)
    print ""



##############
# main
##############

def main():
    dpid = "0000000000000001"
    try:
        CONF(default_config_files=['OpenFlow.ini'])
        route_dist = CONF.Vrf.route_dist
    except cfg.ConfigFilesNotFoundError:
        print "Error: Not Found <OpenFlow.ini> "

    start_delete_vrf(dpid, route_dist)

if __name__ == "__main__":
    main()

