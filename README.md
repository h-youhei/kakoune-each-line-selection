# Each Line Selection for Kakoune
## Usage
```
abc
abc abc
abc abc abc
abc abc
```
Select lines `x`.

Split lines `S`; Here, we split by spaces, so `S\s<ret>`

[] means contents are selected.
```
[abc]
[abc] [abc]
[abc] [abc] [abc]
[abc] [abc]
```

Let's select each line!

Run next command `:keep-selection-each-line<ret>`

It keeps last selection of each line.
```
[abc]
abc [abc]
abc abc [abc]
abc [abc]
```
You can also prepend count. `2:keep-selection-each-line<ret>`

It keeps 'count'th selection of each line.
```
abc
abc [abc]
abc [abc] abc
abc [abc]
```
There is also drop command. `:drop-selection-each-line<ret>`
```
abc
[abc] abc
[abc] [abc] abc
[abc] abc
```
Drop command also accepts conut to be sure. `2:drop-selection-each-line<ret>`
```
[abc]
[abc] abc
[abc] abc [abc]
[abc] abc
```

If you like these, map or alias it.

## Install
Clone this repo and symlink each-line-selection.kak to autoload directory.

