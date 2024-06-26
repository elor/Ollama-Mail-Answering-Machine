#!/bin/bash

set -e -u

# -1 start `ollama serve` if necessary
# 0. take screenshot
# 1. Verify that the image file in $1 exists
# 2. Read the text in the file using tesseract
# 3. connect to ollama llama3 and ask it to consider the text from the file to be an email, and wanting to answer that email
# 4. Print the response from the llama3 server
# 99. Kill `ollama serve` if we started it

OLLAMA_SERVER=localhost
OLLAMA_PORT=11434

if nc -z $OLLAMA_SERVER $OLLAMA_PORT; then
	:
else
	echo "ollama server required. Start with \`brew services start ollama\`"
	exit 1
fi

# 0.
image_file=$(mktemp).png

## Take the screenshot using the screencapture command
screencapture -i -t png "$image_file"

# 1.
if [ ! -f "$image_file" ]; then
	echo "Image file not found"
	exit 1
fi

# 2.

mail_content=$(tesseract -l deu "$image_file" stdout)

cat <<EOF
detected Mail:
$mail_content

Copying mail content to clipboard...
EOF
pbcopy <<<"$mail_content"

# 3.

system_prompt="Du erhältst eine E-Mail. Bitte antworte darauf. Antworte nicht auf AGB, Datenschutzbedingungen oder sonstigen Inhalt in Signaturen. Du heißt Erik E. Lorenz, oder kurz Erik."

full_prompt="$system_prompt

Die Mail:

$mail_content

Deine Antwort:"

prompt='{
  "model": "llama3",
  "stream": false,
  "prompt": '$(jq -Rs <<<"$full_prompt")'
}'

# remove single newlines. Keep double newlines
response=$(curl -Ns http://$OLLAMA_SERVER:$OLLAMA_PORT/api/generate -d "$prompt" | jq -r .response)

cat <<EOF

$response

Copying answer to clipboard...
EOF

pbcopy <<<"$response"

# clean up:
## remove the temporary image file
rm -f "$image_file"
