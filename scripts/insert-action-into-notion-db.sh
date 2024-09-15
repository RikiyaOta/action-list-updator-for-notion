#!/bin/bash

set -e

# 以下APIでNotion DBにデータを登録する（バルクINSERT的なものはないみたい）
# https://developers.notion.com/reference/post-page

if [ "$NOTION_API_KEY" = "" ]; then
    echo "環境変数 NOTION_API_KEY が登録されていません。"
    exit 1
fi

if [ "${ACTION_LIST_RECORD_DB_ID}" = "" ]; then
    echo "環境変数 ACTION_LIST_RECORD_DB_ID が登録されていません。"
    exit 1
fi

category="$1"
name="$2"
point="$3"
date="$4"

curl 'https://api.notion.com/v1/pages' \
  --retry 3 \
  --retry-delay 1 \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  --data '{
	"parent": { "database_id": "'"${ACTION_LIST_RECORD_DB_ID}"'" },
	"properties": {
    	"category": {
            "select": {
              "name": '"${category}"'
            }
    	},
        "done": {
            "checkbox": false
        },
        "date": {
          "date": {
            "start": "'"${date}"'"
          }
        },
        "point": {
          "id": "n%40%5C%7B",
          "type": "number",
          "number": '${point}'
        },
        "action": {
          "title": [
            {
              "text": {
                "content": '"${name}"'
              },
              "plain_text": '"${name}"'
            }
          ]
        }
	}
  }'
