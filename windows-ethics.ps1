Write-Host "Generating ethics document"

# Should be a copy of https://docs.google.com/document/d/1y4Gjx9cKh3-iXG3HsPghtEVKo4BujKWM166d1CoLIlw/edit
$FORM_VALUES='https://docs.google.com/document/d/1B3t8EirnEX6q94-1qLmb13czzleDNEWetXKEtND_Cxw/edit?usp=sharing'

# Should be a copy of https://docs.google.com/document/d/1R0_xQvjYrq384j0ur_1CNCEQvOPBQTCxM4Gq_XWd4iY/edit
$METHOD='https://docs.google.com/document/d/1ZoPz88HiPUi48eOmyuqZLSpyGk4SoYUpg6nbY4Kt0zE/edit?usp=sharing'

# Should be the appropriate template for your specific type of study.
# Below is the template for controlled experiments.
$TEMPLATE='https://docs.google.com/document/d/1H6qSh_Sxa9evRSMIRZU3fXlwpY0P1rUPcf6DprLDIWg/edit#heading=h.sf9x54t3fugz'

# Get the CSS file first 
# TODO: Replace this with your own path to gdoc2pdf\src\styles\no-h3.css
$CSS='C:\Users\chery\gdoc2pdf\src\styles\no-h3.css'
# TODO: Replace this with your own path to gdoc2pdf\src\styles\no-h3.css
$CSS_HEADERS='C:\Users\chery\gdoc2pdf\src\styles\with-highlights.css'

# Figure out where pwdiff is for our diffs
$PWDIFF=".\pwdiff"

# Create a folder with the appropriate time 
$FOLDER=Get-Date -Format "yyy-MM-dd-H\hmm"
$LOCATION = Get-Location

New-Item -Path $LOCATION -Name $FOLDER -ItemType "directory"


Write-Host "Form Values"


gdoc2pdf -f $FORM_VALUES -v none -o "$FOLDER/0-formvals.md"

Copy-Item "$FOLDER/0-formvals.md" "$FOLDER/0-formvals-final.md"

md-to-pdf --stylesheet $CSS "$FOLDER/0-formvals-final.md"


Write-Host "Method"

gdoc2pdf -f $METHOD -t $TEMPLATE -o "$FOLDER/1-method.md"

Copy-Item "$FOLDER/1-method.md" "$FOLDER/1-method-final.md"

md-to-pdf --stylesheet $CSS "$FOLDER/1-method-final.md"



Write-Host "Consent Form"

$CONSENT='https://docs.google.com/document/d/1EffPq6GcAEmVJo29hvets215AY3NDxFcM8OahDiTwjk/edit'

gdoc2pdf -f $CONSENT -v $FORM_VALUES -o "$FOLDER/2-consent.md" -c $CSS

Copy-Item "$FOLDER/2-consent.md" "$FOLDER/2-consent-final.md"

md-to-pdf --stylesheet $CSS "$FOLDER/2-consent-final.md"


Write-Host "Recruitment Text"

$RECRUIT='https://docs.google.com/document/d/1n45fYI1TSWuzMsQdnvw5j_R3MxF9e2JG_m44yYU1R_o/edit'
gdoc2pdf -f $RECRUIT -v $FORM_VALUES -o "$FOLDER/3-recruit.md" -c $CSS

Copy-Item "$FOLDER/3-recruit.md" "$FOLDER/3-recruit-final.md"
md-to-pdf --stylesheet $CSS "$FOLDER/3-recruit-final.md"



Write-Host  'Feedback text'

$FEEDBACK='https://docs.google.com/document/d/1atErn8uSQ9JH-3T6JevJTOF4VwzSAmmIvVJfV6ucz4o/edit'
gdoc2pdf -f $FEEDBACK -v $FORM_VALUES -o "$FOLDER/4-feedback.md" -c $CSS

Copy-Item "$FOLDER/4-feedback.md" "$FOLDER/4-feedback-final.md"

md-to-pdf --stylesheet $CSS "$FOLDER/4-feedback-final.md"


Write-Host  'Combine'


cd $FOLDER

Write-Output 'all.pdf' | pdfmerge -a

# Go back to the original location
cd $LOCATION