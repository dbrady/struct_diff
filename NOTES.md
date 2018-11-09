# Dev Diary: Thoughts, Prayers, Notes, etc

## Friday, 2018-11-09

As I move this from a kludgy one-method hack that only handles hashes on the
console to a more general-purpose tool, the first thing I want to do is test
it. But the existing script dumps directly to the console and includes ANSI
colors from the colorize gem. I have an essential feature I need to add ASAP
(rendering differences between Arrays), and this is proving to be tricky enough
to do that I can't just hammer another wart onto the existing pile of hacks. I
actually *NEED* to test-drive this thing.

I think I need to separate the notion of detecting/identifying difference from
the notion of rendering it. This is turning out to be much harder than
anticipated. Detecting the difference is easy; it's coming up with an
intermediate representation that is renderable that has me flummoxed. Hmm. For
now I'll start by TDD'ing the difference part and see if that leads me
somewhere.
