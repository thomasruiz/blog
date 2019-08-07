---
title: "Going Live"
date: 2019-08-06T18:46:55+02:00
---

# Here we go!

It's about time I finally start blogging. I always wanted to write about my work and shamelessly rant about things I hate. Because, let's be honest, there's **a lot** to hate in our field.

Anyway, here I am, after a few years of thinking about it, deploying my first CMS to github pages. Let's see why and how I did that.

## Choices are hard

I've already written a few articles on the web. [One is on Medium](https://medium.com/neoxia/une-introduction-à-larchitecture-en-microservices-serverless-45d2e89c3c1f) (it's an interview, but still relevant!), and [one is published](https://www.journaldunet.com/solutions/expert/70213/5-prerequis-indispensables-a-une-demarche-de-developpement-de-microservices.shtml) to several online newspapers (all in french, sorry!).

When you want to start blogging, you have several different options available to you. You can choose to write on an existing blogging platform, use a CMS, _write your own platform_,... Let's see the pros and cons relevant to me.

### Existing blogging platform

#### Pros

* It's really easy to get started
* It's mostly free
* You have nothing to do but write content
* Recognition is easier
* There are tons of features

#### Cons

* Someone else owns your stuff and makes money out of it
* You cannot change anything about the platform
* There can be bad features and missing ones
* Quality is very relative


### CMS

#### Pros

* It's moderately easy to get started
* It _can_ be free
* You can change everything on it, with a little bit of work
* You're not bound to another company

#### Cons

* You gotta find something that suits your needs
* You're responsible for SEO, security, hosting (not always),...

### DIY

#### Pros

* ... I guess it's fun to build things? But you won't be writing anything anytime soon

#### Cons

* It's costly, in time and money
* You have to do everything
* I thought you wanted to blog?
* Let's just say that it's a bad idea

### So, which one?

In the end, it's a matter of what you prefer. I honestly like blogging platforms, due to their simplicity, but let's be honest: I love golang, I heard only good things about Hugo, so it's time to give it some love as well. And here I am, installing Hugo with a simple `yay hugo` (yes, I'm on archlinux), and starting a new blog: `hugo new site blog`.

## Hugo

### The theme
Once my blog was created, I had to choose a theme. After a few minutes of indecision, I chose a simple but efficient one: Paper.

```bash
$ git init
$ git submodule add https://github.com/nanxiaobei/hugo-paper themes/hugo-paper
$ echo 'theme = "hugo-paper"' >> config.toml
```

{{< figure src="/posts/2019-08/going-live-files/it-works.png" title="And voilà, it works!" class="image-center" >}}

### A simple page

Okay, that was easy. What's next? How about an about me page: `hugo new pages/about-me` creates a MarkDown file in the content/pages directory. Writing a few things and boom, got myself a page. I apparently have a few things to add to the configuration.

#### Configuration

First, I want to replace my base url and title. Yeah, that's a lot of backslashes, but I'm making this for you guys. Obviously, you can use any editor, as I did, but now you know how to replace some text in a file with a shell.

```bash
$ sed -i s/http:\\/\\/example.org\\//https:\\/\\/blog.thomasruiz.fr\\// config.toml
$ sed -i s/My\ New\ Hugo\ Site/Thomas\ Ruiz\ Blog/ config.toml
```

Next, I want to change my date format. A quick duckduckgo search lead me to this:

```bash
$ tee -a config.toml

[params]
  dateFormat = "02 January 2006"
```

We're civilized, so we space out things. Why Jan 2 2006, you asked? [Because it's simply 1 2 3 4 5 6 7](https://golang.org/pkg/time/#pkg-constants).

#### Custom CSS

My page could use some custom css too, so how does this work? Documentation is boring, let's figure out how that theme works.

{{< highlight html "linenos=table,linenostart=34" >}}
{{ if eq (getenv "HUGO_ENV") "production" | or (eq .Site.Params.env "production") }}
{{ template "_internal/google_analytics_async.html" . }}
{{ end }}
{{ partial "header-include.html" . }}
</head>
{{< / highlight >}}

Hey, cool! There's even a google analytics thing I can use. I'd love to use Matomo, but I really don't want to spin up a server for this. Anyway.

The interesting part is the partial line. Apparently, it's including some `header-include.html` file. Let's create one in `/layouts/partials`, just like the theme does, and include my css file.

{{< gif "2yIf8GM4TBa0g" >}}

Splendid! It works!

#### Menus

Last but not least, my page cannot be accessed from anywhere, so how do you do menus? Again, duckduckgo told me everything:

```bash
$ tee -a config.toml <

[menu]
  [[menu.main]]
    identifier = "about"
    name = "about me"
    url = "/pages/about-me"
```

Now, I can start typing this blog post with a simple `hugo new posts/2019-08/going-live`.

## Live!

I had to fix and figure out a few things, but overall it worked as expected. Now I've decided to deploy to github pages. Let's go! [There's even a guide](https://gohugo.io/hosting-and-deployment/hosting-on-github/) explaining everything, great.

After a few clicks creating repositories, a few commands and some tweakering of DNS settings, we're live!

I hope you liked what you read. There's still a few things I need to do, like setting up google analytics and a RSS flux.
