# All the tasks that go into generating the site
all: pages posts www/assets

# These phony task don't name the files they generate specifically.
# That means they'll run every time make is called
# A more sophisticated file for a complicated site might only build files that have changed.
.PHONY: pages posts

# We're going to invoke taft a couple of times, here are some general flags.
TAFTFLAGS = --helper 'site/helpers/*.js' \
	--layout 'site/layouts/*.handlebars' \
	--partial 'site/partials/*.handlebars' \
	--data posts.yaml \
	--data pages.yaml

# Generate the posts
DATA = posts.yaml pages.yaml
LAYOUTS = $(wildcard site/layouts/*)
POSTS = $(wildcard site/posts/*.html)
PAGES = $(wildcard site/*.html)

posts: $(subst site/,www/,$(POSTS))
pages: $(subst site/,www/,$(PAGES))

$(subst site/,www/,$(POSTS)): www/posts/%.html: site/posts/%.html $(DATA) $(LAYOUTS) | www/posts
	taft $(TAFTFLAGS) --default-layout site/layouts/post.handlebars $< -o $@

# Generate the html pages, e.g. the index, the about page, etc.
$(subst site/,www/,$(PAGES)): www/%.html: site/%.html $(DATA) $(LAYOUTS) | www
	taft $(TAFTFLAGS) $< -o $@

# Generate a yaml file with post metadata.
# Each entry will be keyed to the post's slug (e.g. '2016-01-03-tofu').
posts.yaml: $(POSTS)
	yaml-cat --no-ext --cwd $(<D) $(<D)/* > $@

# Generate a YAML file with page metadata
# Each entry will be keyed to the page's filename
pages.yaml: $(PAGES)
	yaml-cat --cwd $(<D) $(<D)/* > $@

# This could be much fancier, with SASS or LESS, rollup, minification, etc.
www/assets/style.css: site/assets/style.css | www/assets
	cp $< $@

www/assets/script.js: site/assets | www/assets
	cp $< $@

# And of course, create the destination folder.
www www/assets www/posts: ; mkdir -p $@
