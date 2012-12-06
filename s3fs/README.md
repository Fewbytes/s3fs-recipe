# Amazon s3fs Recipe

The purpose of this recipe is to create a s3fs driver for one of your amazon s3 buckets.


## Setup

To install, include this recipe and provide your S3 credentials in the `s3fs\access_key` and `s3fs\secret_key` attributes.

To mount a s3fs bucket use a mount resource of the following form, as per your needs:

    mount <local-mount-path> do
      device <S3-bucket-with-possible-inner-path>
      fstype "fuse.s3fs"
      options "allow_other"
      only_if { ::Dir.entries(<local-mount-path>).join == "..." } # only mount if empty
    end

## What does it do?

It will install s3fs on your node, and allow you to mount S3 buckets to local directories.

## Support

If you have any problems or change requests to this recipe please contact team@jackrussellsoftware.com
