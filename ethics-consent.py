import json
import subprocess
import shutil

# Place path to json with ethics variables here
ETHICS_VARS_JSON = "uw-ethics-vars.json"

def main():
    ethics_vars = getEthicsVars()
    css_path = getCSSFile()
    generatePDF(ethics_vars["FORM_VALUES"], ethics_vars["CONSENT_DOC"], css_path)

def getEthicsVars():
    with open(ETHICS_VARS_JSON, "r") as ethics_vars:
       return json.load(ethics_vars)
    
def getCSSFile():
    gdoc2pdf_path = shutil.which("gdoc2pdf")
    if not gdoc2pdf_path:
        raise FileNotFoundError("gdoc2pdf is not installed or not in PATH.")
    
    css_path = gdoc2pdf_path.replace("bin/gdoc2pdf", "lib/node_modules/gdoc2pdf/src/styles/no-h3-no-highlights.css")
    return css_path

def generatePDF(form_values, consent, css_path):
    subprocess.run([
        "gdoc2pdf",
        "-f", json.dumps(consent),
        "-v", json.dumps(form_values),
        "-o", "consent.pdf",
        "-c", css_path
    ], check=True)

if __name__ == "__main__":
    main()
