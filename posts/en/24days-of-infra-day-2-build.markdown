---
title: 24 Days of Infrastructure - Build System
date: 2014-12-02
lang: en
book1: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=0596517335&asins=0596517335&linkId=UIRXWBEECWOULJPE&show_border=true&link_opens_in_new_window=true
book2: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1617291277&asins=1617291277&linkId=RKGHEDDWES3F7BP7&show_border=true&link_opens_in_new_window=true
book3: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1593272839&asins=1593272839&linkId=SJGJYQDCBGHHCZKP&show_border=true&link_opens_in_new_window=true
---

Now that we have our [sources under version control][1],
we should embark on actually building it.
A build tool spares us remembering the actual sequence of commands to complete
the build, while also taking care not to compile in unchanged dependencies in vain.

Traditionally developers had the luxury to work with a single language (say
Java or C) and use a de-facto build system of that language
(say maven or CMake).
If we develop a relatively isolated feature, we might just be able to get away
with that.

But if we are building a moderately sized system, chances are that we can't be
very picky, and have to use the components already around, regardless of the
language they are written in. A piece of Scala here, bits of Haskell there,
eventually calling a native library written in C++...

Therefore the build system should be able to manage building a range of languages,
as well as managing inter-language dependencies.

### Why would I want to build those?

Forgetting about calling native code, let's assume that we only write and build a single language, and use third party components written in other languages.
Why would we want to be able to build those components instead of just using
them as binaries?

Again, we might just get away without. But if you ever depended on a
third-party library, you possibly had to hunt down a peculiar bug in its source
 and patch it. Struggle half a day to compile it. Then hack the build files to make them use the locally patched version, sitting tight waiting for the upstream
maintainers to merge the patch you sent them and eventually release it.

Now, would you be happy investigating how to compile, while all your services
are down due to a bug in one such dependency and customers coming with
pitchforks?

Facebook or Google certainly wouldn't, that's why they have all their sources
in a giant source tree
^[This seemingly sadly discontinued [Google engineering blog][2] discusses why
a more centralized source management approach is more suitable to large source
trees].

### And what about transitive dependencies?

Yes, those libraries tend to have enourmous dependencies, which also have to
be imported to the source tree.

As an added benefit, if you add all third party libraries to a distinct
location, it is easier to verify that all their licenses conform to your usage
^[A dependent library might accidentally declare a more liberal license,
than one of its dependencies would allow. Oops.].
Watch Google's Chris DiBona [explain open source strategies][3] in this video.

### So are there such build tools?

If you are adventourus enough, can write you own build tool based on [Shake][4].
Otherwise keep an eye on [Pants][5] from Twitter and [Buck][6]^[Allegedly soon to have C++ support.] from Facebook.
Google's build tool can even utilize the hermetic nature of builds to perform
[parallel builds in the cloud][7].

  [1]: /posts/en/24days-of-infra-day-1-version-control.html
  [2]: http://google-engtools.blogspot.ch/2011/06/build-in-cloud-accessing-source-code.html
  [3]: https://www.youtube.com/watch/?v=yeDWV7PSbgQ
  [4]: http://shakebuild.com
  [5]: http://pantsbuild.github.io/index.html
  [6]: http://facebook.github.io/buck/
  [7]: http://google-engtools.blogspot.ch/2011/09/build-in-cloud-distributing-build-steps.html
