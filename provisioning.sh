#! /bin/bash
nohup hbase master start &
sleep 20
echo "create 'tsdb-uid',  {NAME => 'id', COMPRESSION => 'NONE', BLOOMFILTER => 'ROW'},  {NAME => 'name', COMPRESSION => 'NONE', BLOOMFILTER => 'ROW'}" | hbase shell
echo "create 'tsdb', {NAME => 't', VERSIONS => 1, COMPRESSION => 'NONE', BLOOMFILTER => 'ROW'}" | hbase shell
echo "create 'tsdb-tree', {NAME => 't', VERSIONS => 1, COMPRESSION => 'NONE', BLOOMFILTER => 'ROW'}" | hbase shell
echo "create 'tsdb-meta', {NAME => 'name', COMPRESSION => 'NONE', BLOOMFILTER => 'ROW'}" | hbase shell