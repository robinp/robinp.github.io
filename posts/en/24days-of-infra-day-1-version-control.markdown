---
title: 24 Days of Infrastructure - Version Control
date: 2014-12-01
lang: en
book1: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1449316387&asins=1449316387&linkId=QSKEID3Y4OY3EGTY&show_border=false&link_opens_in_new_window=true
book2: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1934356727&asins=1934356727&linkId=I4JUM7IMPWRKHZRE&show_border=false&link_opens_in_new_window=true
book3: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=B00K54OL8I&asins=B00K54OL8I&linkId=SPZEKQWK7JV77RZT&show_border=false&link_opens_in_new_window=true
---

Inspired by [24 Days of Hackage][1], this is a post series about (a biased selection of) software infrastructure components found in modern development and serving environment.

We start with development related components like versioning, building and releasing, then move to production components like queues, storange and analysis support.
Our first topic is version control (aka source control).

Hopefully it is no surprise that first thing a developer wants to do when
starting a new project is to put code under version control
(if it is a surprise, execute `git init` before it would be too late).
Code additions and modifications then happen in logical units containing
a set of related changes, called commits.
Code is checkpointed after each commit, so any given state can be restored later.

As opposed to copying sources to a backup periodically, version control lets
us track who changed what on a line by line basis. And if we are lucky, the
commit messages also tell us why. It really is a baseline for multi-, or even
single-developer settings.

### What to version?

Not only source code can be versioned, but any files in general.
It would be frustrating that we can restore source code to a previous state, but not the accompanying config files, wouldn't it?
Therefore it makes sense to put configuration files under source control too
(depending on what configuration means, it probably wouldn't be stored carbon copy, but rather as configuration templates and parameters seperately).

So at this point we can roll the source and configurations back to a given point in time.
But what about compiling the source? Imagine that we roll back to a year old version, and the source at that point used a language feature that got deprecated in the mean time, and the current compiler on the build machine already rejects the source.
Multiply this with the number of tools we depend on, and we have a serious problem.
To avoid such issues, companies like Facebook or Google also keep all the tooling needed to compile the sources along under version control.

### Wait! Even binaries?

Yes. When we roll back, we also get the tools to build with at that point.
This is called a hermetic build (more about building later).

If we are really keen and intend to patch the compiler every now and then, can go deeper and check in sources for the compiler and tools, then make sure the
checked-in binary is the one resulting from compiling those sources.

### Stop, now.

Okay, let's take a step back.
For smaller companies or startups this is quite an overhead on the short term.
But knowing the concept helps evaluataing if the benefit is worth it.

An alternative to checking in tooling is to have them in a versioned repository,
and have the build scripts point to the appropriate version.
Can you spot any drawbacks with this scheme?

  [1]: https://ocharles.org.uk/blog/
