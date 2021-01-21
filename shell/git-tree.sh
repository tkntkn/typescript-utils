MARKER="==="

PRE_GRAPH="%C(red)%h %C(blue)%cd%C(reset)"
POST_GRAPH="%C(yellow)%an%C(auto)%d%C(reset)%x20%s%x20"
FORMAT="${MARKER}${PRE_GRAPH}${MARKER}${POST_GRAPH}"

PRE_OUTPUT=$(git log --no-color --date=format:'%m/%d %H:%M' --pretty="tformat:$PRE_GRAPH" | head -n 1)
HASHLEN=$(echo $PRE_OUTPUT | wc -c | tr -d ' ')
WHITESPACES=$(printf "%$(($HASHLEN))s")

git log --graph \
        --full-history \
        --color \
        --date=format:'%m/%d %H:%M' \
        --pretty="tformat:$FORMAT" $@ \
    | sed "s/^/$WHITESPACES/g" \
    | sed "s/$WHITESPACES\(.*\)$MARKER\(.*\)$MARKER\(.*\)/\2 \1\3/g" \
    | less -RSX;
