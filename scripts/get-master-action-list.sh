#!/bin/bash

set -e

# 以下APIでマスターデータの一覧を取得する
# https://developers.notion.com/reference/post-database-query

if [ "$NOTION_API_KEY" = "" ]; then
    echo "環境変数 NOTION_API_KEY が登録されていません。"
    exit 1
fi

if [ "${ACTION_LIST_MASTER_DB_ID}" = "" ]; then
    echo "環境変数 ACTION_LIST_MASTER_DB_ID が登録されていません。"
    exit 1
fi

curl -X POST "https://api.notion.com/v1/databases/${ACTION_LIST_MASTER_DB_ID}/query" \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H 'Notion-Version: 2022-06-28' \
  -H "Content-Type: application/json"
