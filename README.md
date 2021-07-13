# UW Ethics

This automatically generates ethics documents for the University of Waterloo's ethics board.
Note that the script supports macOS and Linux, but not Windows. Pull requests to support Windows are welcome.

## Setup

### Installing dependencies

You need to install `gdoc2pdf` using [the instructions at this link](https://github.com/gzinck/gdoc2pdf).

-   Make sure `gdoc2pdf` works before starting!
-   Make sure you have Node 15.0.1 or later installed.

### Creating your ethics application

Most parts of the ethics application are standardized in [this Google Drive folder](https://drive.google.com/drive/folders/1_GhFRYPSbbX2w-rKJJmf9VK5aKVpDYLH).
In particular, the `Recruitment Text`, `Feedback Text`, and `Consent Form` is identical for every study. That leaves two documents you need to create for your study.

-   The `FORM_VALUES` doc should be a copy of [https://docs.google.com/document/d/1y4Gjx9cKh3-iXG3HsPghtEVKo4BujKWM166d1CoLIlw/edit](https://docs.google.com/document/d/1y4Gjx9cKh3-iXG3HsPghtEVKo4BujKWM166d1CoLIlw/edit)
-   The `METHOD` doc should be a copy of [https://docs.google.com/document/d/1R0_xQvjYrq384j0ur_1CNCEQvOPBQTCxM4Gq_XWd4iY/edit](https://docs.google.com/document/d/1R0_xQvjYrq384j0ur_1CNCEQvOPBQTCxM4Gq_XWd4iY/edit)
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

### Specifying Google Doc links

As previously mentioned, most Google Doc links do not need changes because they are standardized. However, you need to change the links to `FORM_VALUES` and `METHOD` files in the `uw-ethics-vars` file to the appropriate links.

None of the other files need to be edited.

## Usage

### Original application

First, go into the folder in which you want to generate the ethics forms. Then run:

```sh
ethics
```

This will generate a folder, named based on the date and time, with your ethics documents. `all.pdf` is the combined file.

### Updated application

To show the diff between the original application and the new revisions, you can use the following:

```sh
ethics ./{{PATH_TO_PREVIOUS_APPLICATION_FOLDER}}/ # replace this folder with the folder with your original application
```

This will show a diff with highlighting and strikethroughs. It works by comparing the markdown of the two applications. Because of this, do not delete old applications if you later want to show diffs!

### Consent form only

To generate the consent form, go to a folder and run:

```
ethics-consent
```

This will generate the consent form only with no highlighting.
