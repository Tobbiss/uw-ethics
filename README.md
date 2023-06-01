# UW Ethics

This automatically generates ethics documents for the University of Waterloo's ethics board.
Note that the ethics, ethics-consent, and pwdiff scripts support macOS and Linux, but not Windows.

For Windows users, please run the windows-ethics.ps1 and windows-ethics-consent.ps1 scripts on PowerShell. Pull requests to support pwdiff are welcome.

For M1 Macs, make sure you are using Node 15 or 16 (not Node 17, as on Oct 2021 it has a number of bugs). Note that there is a line in the ./ethics script (line 11) to use Google Chrome for your rendering (puppeteer uses headless Chromium that does not support M1). You need Google Chrome installed for this to work.

## Setup

First, make sure you have Calibri font installed on your computer. If you do not have this font, it's OK, it will just use Arial or sans-serif.

### Installing dependencies

You need to install `gdoc2pdf` using [the instructions at this link](https://github.com/gzinck/gdoc2pdf).

-   Make sure `gdoc2pdf` works before starting!
-   Make sure you have Node 15.0.1 or later installed.

### Creating your ethics application

Most parts of the ethics application are standardized in [this Google Drive folder](https://drive.google.com/drive/folders/1_GhFRYPSbbX2w-rKJJmf9VK5aKVpDYLH).
In particular, the `Recruitment Text`, `Feedback Text`, and `Consent Form` is identical for every study. That leaves two documents you need to create for your study.

-   The `FORM_VALUES` doc should be a copy of [https://docs.google.com/document/d/1y4Gjx9cKh3-iXG3HsPghtEVKo4BujKWM166d1CoLIlw/edit](https://docs.google.com/document/d/1y4Gjx9cKh3-iXG3HsPghtEVKo4BujKWM166d1CoLIlw/edit)
-   The `METHOD` doc should be a copy of the corresponding method doc for your experiment type.
-   (MAC ONLY) If you have any other PDF files to add to the end of the generated PDF, change the `ADDITIONAL_FILES` variable to the path to the file or directory. 
-   For instructions on how to modify the `FORM_VALUES`, refer to the
    `gdoc2pdf` README: https://github.com/gzinck/gdoc2pdf#adding-in-variables

### Downloading repository and adding to \$PATH

To get set up, first pull down this git repo and add it to your `$PATH`.

```sh
# Get the repository
git clone https://github.com/gzinck/uw-ethics.git
cd uw-ethics

# Add uw-ethics to your $PATH
FILE='~/.zprofile' # or '~/.bash_profile'
echo "" >> $FILE
echo "# Macros for UW ethics script" >> $FILE
echo "export PATH=\"$PWD:\$PATH\"" >> $FILE
source $FILE
```

For Windows users:
* Add this git repo to your path variable using the instructions here: https://www.java.com/en/download/help/path.html

* Ensure that you have Java installed: https://www.java.com/en/download/manual.jsp

* Install md-to-pdf using: `npm install md-to-pdf`

### Specifying Google Doc links

As previously mentioned, most Google Doc links do not need changes because they are standardized. However, you need to change the links to `FORM_VALUES`, `METHOD`, and `TEMPLATE` files in the `uw-ethics-vars` file to the appropriate links. Note that the `TEMPLATE` file is the method template for your experiment type.

(CURRENTLY MAC ONLY) The `ADDITIONAL_FILES` variable is an absolute path to a PDF file (or directory of PDFs) which you want to append to the generated ethics application, like questionnaires, additional interview scripts, etc. If you change the default value from `CHANGEME` to a filepath or directory, it'll grab any PDFs at that path and add it to the end of the final generated PDF file. Example: `"/Users/johannwentzel/Desktop/PDFs"` or `"/Users/johannwentzel/Desktop/pre-questionnaire.pdf"`.

None of the other files need to be edited.

## Usage

### Original application

First, go into the folder in which you want to generate the ethics forms. Then run:

```sh
ethics
```

For Windows users, run:
```
& .\windows-ethics.ps1
```

This will generate a folder, named based on the date and time, with your ethics documents. `all.pdf` is the combined file.

Note that if you want to show header 3s in your document, go into the script and change:
```
npx md-to-pdf --stylesheet $CSS "$FOLDER/1-method-final.md"
```

into:
```
npx md-to-pdf --stylesheet ${CSS_HEADERS} "$FOLDER/1-method-final.md"
```

Header 3s are used as comments by default.

### Updated application

To show the diff between the original application and the new revisions, you can use the following (not supported on Windows yet):

```sh
ethics ./{{PATH_TO_PREVIOUS_APPLICATION_FOLDER}}/ # replace this folder with the folder with your original application
```

This will show a diff with highlighting and strikethroughs. It works by comparing the markdown of the two applications. Because of this, do not delete old applications if you later want to show diffs!

### Consent form only

To generate the consent form, go to a folder and run:

```
ethics-consent
```

For Windows users, run this instead:
```
& .\windows-ethics-consent.ps1
```

This will generate the consent form only with no highlighting.
