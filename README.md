# Qolor

An atom package to color your queries!

Qolor applies semantic highlighting to your SQL queries by matching tables to
their aliases.

All colors of tables are deterministic and based on their name.
They will be the same on any Atom editor anywhere!

(Please feel free to create issues of broken cases with screen shots or text
samples!)

## Installation

    apm install qolor

## Settings

Two stylistic flavors.  Underline or a border box.  This is more of a
placeholder for now.  I only built this to facilitate pull requests etc.

## Optional Keymap To Toggle

Go to Atom -> Open Your Keymap and enter the following:

    'atom-workspace':
      'ctrl-alt-q': 'qolor:toggle'

    # Careful, don't override your existing 'atom-workspace'!

## Prior Art / Related Works

I got the idea for Qolor while working with a large query.
We all play a frustrating game of connect the dots while mentally parsing ("grokking") aliases to their tables.  Colors can help you hunt down the aliases.

Later a friend pointed out that a lot of related work in the area of
"semantic highligting" already exists!
Although, I have yet to find one that does this semantic highlighting for SQL in this table to alias manner.
Let me know if it does!

Here are some of the related links:

*   [Coding in Color](https://medium.com/programming-ideas-tutorial-and-experience/coding-in-color-3a6db2743a1e)
*   [Semantic Highlighting in KDevelop](http://zwabel.wordpress.com/2009/01/08/c-ide-evolution-from-syntax-highlighting-to-semantic-highlighting/)
*   [Sublime-Colorcoder](https://github.com/vprimachenko/Sublime-Colorcoder)
*   [recognizer (Brackets)](https://github.com/equiet/recognizer)
*   [Polychromatic (Xcode)](https://github.com/kolinkrewinkel/Polychromatic)
*   [language-javascript-semantic (Atom)](https://atom.io/packages/language-javascript-semantic)

## How it works

Qolor uses the language-sql grammar built into Atom.
The code performs a double pass.
First pass for the table names and second pass for the aliases.

I don't know of any SQL parsers in node usable for this project.

The code is ugly.  Atom's grammar (evolved from textmate/sublime) for SQL
suffices for syntax coloring, but it's tokens aren't always accurate.
I try to make a layer of rules on top.

It should work for most cases, but please report any issues.

Your performance should be unaffected because qolor utilizes the debounced api
for observing the grammar and because well, computers are fast.

## TODO

*   Custom styling of underline / border.

*   Better handling of colors.  Possibly hue blending etc.  Leverage theme
information.  I still want these to be deterministic but for example,
perhaps a marginal shift of the colors to play nicely with the themes.
Pull requests?

*   Jump to and from matching tables and aliases under cursor.

*   List number of references in the status bar.

*   Add qolor to the minimap.

*   Stats report of all tables or projected fields.
Maybe visual like a minimap?  Query execution plans etc.

*   Some treatment of matching or applicable fields names?

## My other Atom package :)

*   [Jumpy](https://atom.io/packages/jumpy)
