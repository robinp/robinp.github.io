---
title: 24 Days of Infrastructure - Docker Containers
date: 2014-12-04
lang: en
book1: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=0133390098&asins=0133390098&linkId=CXM7TLX5ZXBNICU2&show_border=true&link_opens_in_new_window=true
book2: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1491944935&asins=1491944935&linkId=KMMKEXY6VFAZ6WWO&show_border=true&link_opens_in_new_window=true
book3: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=0672329468&asins=0672329468&linkId=SNOXQLG2AISS564F&show_border=true&link_opens_in_new_window=true
---

[Docker][1] is the new buzz, and for good reason.
It is versatile tool for quickly provisioning new service instances.
The service lives in a full-fledged linux server, packaged as a container.

Compared to virtual machines, Docker containers are quicker to deploy for two reasons.

First, starting a new container doesn't bring up a whole virtual machine,
but utilizes the [Linux kernel's container support][2] to instanly bring up
isolated jails. Starting or destroying containers happens in sub-seconds.

Second, Docker is able to compose the filesystem of a container from layers.
Usually there is a stable base layer carrying the OS and tooling.
This changes infrequently and can be cached on the nodes.
Then there are thinner, application-specific layers.
We can pack our service into such a layer, and even if we push multiple updates
per day, pushing these layers to all nodes is faster than having to push
whole images.

Existing provisioning tools like Chef or Puppet already had the ability to
bring updated package versions to the whole cluster,
but we still had to deal with node heterogenity.
With Docker all we need is to provision the Docker support once, and then we
can push the same container everywhere, regardless of the node OS.

Docker also has a central repository, the [Hub][3],
here we can push public images, or browse and pull a range of existing ones.
For private installations we can run our own Docker repository.

Docker can be used not just for clusters, but for local development too
^[A 64bit host is needed for running Docker.].
Want to install some experimental packages, but don't want to mess up the
system or fiddle with uninstall?
Just boot up a container, install the package there, play with it, and destroy.

Have fun!

  [1]: https://www.docker.com/
  [2]: https://linuxcontainers.org/lxc/introduction/
  [3]: https://registry.hub.docker.com/

