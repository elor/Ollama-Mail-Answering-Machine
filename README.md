Ollama-Mail-Answering-Machine: A Script to Automate Email Responses
===============================================================

**Overview**
------------

The Ollama-Mail-Answering-Machine is a shell script that takes a screenshot of an email, performs text extraction using `tesseract-ocr`, and then uses the `ollama` tool to generate a response based on the extracted text. This script is designed specifically for MacOS users and currently supports German language, because I didn't care to detect the language of the mail and it works well enough.

This README.md was auto-generated by the script itself.

**Features**
------------

* Takes a screenshot of an email using `screencapture`
* Performs text extraction using `tesseract-ocr`
* Runs the extracted text through `ollama` to generate a response
* Currently supports German language only, because I didn't care to detect the language of the mail and it works well enough.

**Requirements**
----------------

* MacOS (only)
* `tesseract-ocr` installed (part of Tesseract OCR package)
* `ollama` installed (part of LLaMA package)
* `screencapture` command enabled in your terminal, with proper permissions to take screenshots of other apps

**Usage**
---------

1. Save the script (`screenshot_and_answer.sh`) to a directory on your machine.
2. Run the script by executing the command: `./screenshot_and_answer.sh`
3. The script will prompt you to take a screenshot of an email using `screencapture`.
4. After taking the screenshot, the script will extract text from the image and run it through `ollama` to generate a response.
5. The generated response will be displayed in the terminal.

Why Screenshots and text extraction?
------------------------------------

Some of my inboxes are only accessible through remote desktop software which doesn't support clipboard sharing.
By using screenshots, it works well enough for both use cases, clipboard or not.

**Limitations**
----------------

* Currently only supports German language
* Only works on MacOS (no Linux or Windows support for now)
* Requires manual intervention to take a screenshot of an email

**Troubleshooting**
--------------------

If you encounter any issues, please refer to the script's error messages or contact me for assistance.

**License**
---------

This script is released under the MIT License. See `LICENSE` file for details.

Happy automating!
