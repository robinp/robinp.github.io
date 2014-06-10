---
title: Readroll of June 2014
date: 2014-06-10
lang: en
---

Posts
-----

#### [Exceptions and monad transformers](http://www.yesodweb.com/blog/2014/06/exceptions-transformers)

  Summarizes the differences between, and discusses appropriate use cases for the `exceptions` and `monad-control` packages. Michael proposes using `MonadMask` and pals from `exceptions` unless more power is needed.

#### [HydraBase @ Facebook](https://code.facebook.com/posts/321111638043166/hydrabase-the-evolution-of-hbase-facebook/)

  HydraBase is an upgrade of HBase, where region server failover is sped up by having replicas with quorum. Seems similar to Google's [Megastore](http://static.googleusercontent.com/media/research.google.com/hu//pubs/archive/36971.pdf), but (among others) uses [RAFT](https://ramcloud.stanford.edu/wiki/download/attachments/11370504/raft.pdf) for consensus instead of Paxos.

#### [Column-oriented storage @ Facebook](https://code.facebook.com/posts/229861827208629/scaling-the-facebook-data-warehouse-to-300-pb/)

  Column-oriented storage formats can be encrypted way better with tons of heuristic-based special-casing applied. Here is a link to Google's column-oriented [Dremel](http://static.googleusercontent.com/media/research.google.com/hu//pubs/archive/36632.pdf) warehouse paper as a self-reference. I also remember having read a similar compression paper, but can't recall it.

#### [Graph partitioning @ Facebook](https://code.facebook.com/posts/274771932683700/large-scale-graph-partitioning-with-apache-giraph/)

  [Apache Giraph](https://giraph.apache.org/) is the open-source alternative of [Pregel](http://kowshik.github.io/JPregel/pregel_paper.pdf), a massively parallel graph processing system. Used at Facebook to partition to graph to roughly equal-sized clusters using a stochastic node-swapping algorithm to minimize inter-partition edge weights.

Papers
------

#### [Type-Safe Observable Sharing in Haskell](http://www.cs.uu.nl/wiki/pub/Afp/CourseLiterature/Gill-09-TypeSafeReification.pdf)

  A nice technique based on GHC's stable names to make reference loops observable in pure EDSL-s. This is advised to be used more as an optimization than a guarantee, since the exact sharing might not always appear.

Books
-----

Stackoverlow
------------
