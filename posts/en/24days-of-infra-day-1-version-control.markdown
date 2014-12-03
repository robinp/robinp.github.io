---
title: 24 Days of Infrastructure - Version Control
date: 2014-12-01
lang: en
book1: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1449316387&asins=1449316387&linkId=QSKEID3Y4OY3EGTY&show_border=false&link_opens_in_new_window=true
book2: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=1934356727&asins=1934356727&linkId=I4JUM7IMPWRKHZRE&show_border=false&link_opens_in_new_window=true
book3: //ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=robinp-20&marketplace=amazon&region=US&placement=B00K54OL8I&asins=B00K54OL8I&linkId=SPZEKQWK7JV77RZT&show_border=false&link_opens_in_new_window=true
---

Inspired by [24 Days of Hackage][1], this is a post series about software infrastructure components found in a modern development and serving environment.

We start with development related components, and will move to other elements
of serving thereafter. The first topic we touch is version control (aka source control).

Hopefully it is no surprise that first thing a developer wants to do when
starting a new project is to `git init`. Version control lets you checkpoint
source code (take snapshots of the whole codebase), and do it in an efficient
way (no duplication of data).

As opposed to copying sources to a backup periodically, version control lets
you track who changed what on a line by line basis. And if you are lucky, the
commit messages also tell you why. It really is a baseline for multi-, or even
single-developer settings.

### What to version?

In fact, not only source code can be versioned, but any files in general.
For example, it makes sense to put configuration files under source control.
It would be frustrating that you could restore source code to a previous state, but not the accompanying config files, wouldn't it?

Also, depending on what configuration means, it probably wouldn't be stored carbon copied, but rather as configuration templates and parameters seperately.

So at this point we can roll the source and configurations back to a given point in time.
But what about building it? Imagine that you roll back to a one year old version, and the source at that point used a language feature that got deprecated in the mean time, and the current compiler on the build machine already rejects the source.
Multiply this with the number of tools you depend on, and you have a serious problem.
To avoid such issues, companies like Facebook or Google also keep all the tooling needed to compile the sources along under version control.
When you roll back, you also get the tools to build with at that point.
(If we are really keen and intend to patch the compiler every now and then, can go deeper and check in sources for the compiler and other tools too).

But you wouldn't normally check in binaries to git, since it would be a burden
for each developer cloning the repository.
At this point fallback to less distributed version control seems needed.
[Google blogs][2] that the versioned files are not actually present on the
developer machines, but a virtual filesystem makes it seem so.
File content is actually retrieved, when the developer marks files for edit.

  [1]: https://ocharles.org.uk/blog/
  [2]: http://google-engtools.blogspot.ch/2011/06/build-in-cloud-accessing-source-code.html
