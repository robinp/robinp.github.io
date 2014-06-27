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

#### [Jackknife statistics in O(n)](http://www.serpentine.com/blog/2014/06/10/win-bigger-statistical-fights-with-a-better-jackknife/)

  An interesting read about statistics and numerical stability of summing (with stable implementations in the [math-functions](http://hackage.haskell.org/package/math-functions) package).

#### [The problem with mtl](http://ro-che.info/articles/2014-06-11-problem-with-mtl.html)

  Outlines some shortcoming in the monad classes of the mtl. As others pointed out, using `zoom` from a lens library could ease the pain, but the author is not keen on lens.

#### [Open decision making](http://www.stanford.edu/~ouster/cgi-bin/decisions.php)

  Interesting thoughts about a successful decision-making process. Gather input in broad-narrow phases, seek consensus by public voting, optionally intervene/override, and finally announce the decision. Don't change or reevaluate a decision unless there is significant new information available. The public voting has a nice part, where pros/cons are put up on display, and one is not allowed to discuss anything that is already up (this prevents fruitless arguing).

#### [Roles in GHC's type system](https://ghc.haskell.org/trac/ghc/wiki/Roles)

  GHC 7.8 implemented type roles to avoid a possible unfortunate interplay between newtyping and `GeneralizedNewtypeDeriving`. In short, newtyping creates a new Haskell-level type, but `GND` works on the machine representation level. This impedance mismatch can cause quirks as demonstrated in the page.

  The solution was to make the so-far implicit type coercion of `GND` explicit: There is a new `Coercible a b` class, for which an instance exists only if the types are legally coercible (on the machine representation level). The compiler automatically infers Representational / Nominal role for type variables, and the instance exists if `a` has Representational role.

  Nominal role happens for example when a type variable of a type doesn't appear in the constructor definitions (possibly with `GADT`s or type families). There is also a small niche for phantom types and the Phantom role.

#### [What happens to stolen bikes](http://blog.priceonomics.com/post/30393216796/what-happens-to-stolen-bicycles)

  In short: they get sold in remote cities.

Papers
------

#### [Type-Safe Observable Sharing in Haskell](http://www.cs.uu.nl/wiki/pub/Afp/CourseLiterature/Gill-09-TypeSafeReification.pdf)

  A nice technique based on GHC's stable names to make reference loops observable in pure EDSL-s. This is advised to be used more as an optimization than a guarantee, since the exact sharing might not always appear.

Fun
---

#### [Don't shoot portrait videos (YT)](https://www.youtube.com/watch?v=Bt9zSfinwFA)

  With fun puppet characters, but not 100% family friendly.

#### [How software is engineered (YT)](https://www.youtube.com/watch?v=9HQyuSSbYak)

  This is the trailer from a Lego movie, showing how the idea of building a submarine concieves and how is it implemented. Can you spot the parallel?

Stackoverlow
------------
