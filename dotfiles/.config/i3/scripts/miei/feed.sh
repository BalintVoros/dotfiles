#!/usr/bin/env bash

STATE_FILE="/tmp/feed_toggle_state"
INDEX_FILE="/tmp/feed_index_state"
RSS_URL="https://news.google.com/rss?hl=hu&gl=HU&ceid=HU:hu"

# Initialize state if missing
if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi

if [ ! -f "$INDEX_FILE" ]; then
    echo "1" > "$INDEX_FILE"
fi

a=$(cat "$STATE_FILE")
i=$(cat "$INDEX_FILE")

# Fetch RSS feed and parse titles + links
readarray -t titles < <(curl -s "$RSS_URL" | grep -oP '(?<=<title>).*?(?=</title>)')
readarray -t links < <(curl -s "$RSS_URL" | grep -oP '(?<=<link>).*?(?=</link>)')

# First 2 items are feed metadata, so actual articles start at index 2
num_articles=$((${#titles[@]} - 2))

# Handle left click
if [ "$BLOCK_BUTTON" == "1" ]; then
    if [ "$a" == "0" ]; then
        echo "1" > "$STATE_FILE"
        echo "1" > "$INDEX_FILE"
        a=1
        i=1
    else
        i=$((i + 1))
        if [ "$i" -gt "$num_articles" ]; then
            i=1
        fi
        echo "$i" > "$INDEX_FILE"
    fi
fi

# Handle right click (open article)
if [ "$BLOCK_BUTTON" == "3" ] && [ "$a" == "1" ]; then
    article_link="${links[$((i + 1))]}"
    xdg-open "$article_link"
fi

# Handle middle click (reset to "Hírek")
if [ "$BLOCK_BUTTON" == "2" ]; then
    echo "0" > "$STATE_FILE"
    echo "1" > "$INDEX_FILE"
    a=0
fi

# Display
if [ "$a" == "1" ]; then
    article_title="${titles[$((i + 1))]}"
    echo "📰 $article_title"
else
    echo "📰"

fi

