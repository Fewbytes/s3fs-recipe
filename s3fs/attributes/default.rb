#These can be left as is:
default['s3fs']['fuse_version'] = '2.8.7'
default['s3fs']['fuse_url'] = "http://downloads.sourceforge.net/project/fuse/fuse-2.X/2.8.7/fuse-2.8.7.tar.gz"
default['s3fs']['s3fs_version'] = 'c-1.61'
default['s3fs']['s3fs_url'] = "http://public.fewbytes.com/s3fs-c-44453f6.tar.gz"

#These must be overwritten:
default['s3fs']['access_key'] = nil
default['s3fs']['secret_key'] = nil
