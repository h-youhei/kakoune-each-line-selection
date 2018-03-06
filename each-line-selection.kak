define-command -docstring 'Keep last selection each line.
If count is given, keep nth selection each line instead.' \
keep-selection-each-line %{ %sh{
	if [ $kak_count -eq 0 ] ; then
		echo _keep-last-selection-each-line
	else
		echo _keep-nth-selection-each-line
	fi
}}

define-command -docstring 'Drop last selection each line.
If count is given, drop nth selection each line instead.' \
drop-selection-each-line %{ %sh{
	if [ $kak_count -eq 0 ] ; then
		echo _drop-last-selection-each-line
	else
		echo _drop-nth-selection-each-line
	fi
}}

define-command -hidden _keep-last-selection-each-line %{ %sh{
	old_selections=`echo $kak_selections_desc | tr : '\n' | sort -n`
	selections=
	prev_line=`echo $old_selections | cut -f 1 -d '.'`
	last_sel=

	for sel in $old_selections ; do
		line=`echo $sel | cut -f 1 -d '.'`
		if [ $line -ne $prev_line ] ; then
			selections=$selections:$last_sel
			prev_line=$line
		fi
		last_sel=$sel
	done
	selections=$selections:$last_sel
	echo "select ${selections#:}"
}}

define-command -hidden _keep-nth-selection-each-line %{ %sh{
	old_selections=`echo $kak_selections_desc | tr : '\n' | sort -n`
	selections=
	prev_line=`echo $old_selections | cut -f 1 -d '.'`
	i=1

	for sel in $old_selections ; do
		line=`echo $sel | cut -f 1 -d '.'`
		if [ $line -ne $prev_line ] ; then
			i=1
			prev_line=$line
		fi
		[ $i -eq $kak_count ] && selections=$selections:$sel
		i=$(($i+1))
	done
	echo "select ${selections#:}"
}}

define-command -hidden _drop-last-selection-each-line %{ %sh{
	old_selections=`echo $kak_selections_desc | tr : '\n' | sort -n`
	selections=
	prev_line=`echo $old_selections | cut -f 1 -d '.'`
	last_sel=

	for sel in $old_selections ; do
		line=`echo $sel | cut -f 1 -d '.'`
		if [ $line -eq $prev_line ] ; then
			[ -z $last_sel ] || selections=$selections:$last_sel
		else
			prev_line=$line
		fi
		last_sel=$sel
	done
	echo "select ${selections#:}"
}}

define-command -hidden _drop-nth-selection-each-line %{ %sh{
	old_selections=`echo $kak_selections_desc | tr : '\n' | sort -n`
	selections=
	prev_line=`echo $old_selections | cut -f 1 -d '.'`
	i=1

	for sel in $old_selections ; do
		line=`echo $sel | cut -f 1 -d '.'`
		if [ $line -ne $prev_line ] ; then
			i=1
			prev_line=$line
		fi
		[ $i -ne $kak_count ] && selections=$selections:$sel
		i=$(($i+1))
	done
	echo "select ${selections#:}"
}}
