# Taft Demo Site

This is a demonstration of [Taft](http://github.com/fitnr/taft) used as a basic blog site.

New posts are HTML files with YAML front matter, placed in the `site/posts` directory.

The Makefile generates new posts and pages with the simple command `make`.

## How to

Clone the repository and run:
```
npm install -g taft yaml-cat
```

(YAML-cat is a tiny tool for pulling info from pages with YAML front matter.)

You'll also need [Make](https://www.gnu.org/software/make/), which is pretty common. 

To generate the site, run `make`.

## Suggested additions

* Add a Markdown helper to enable Markdown posts.
* Add support for Sass or LESS for CSS pre-processing.
* Add JS minification and concatenation.
