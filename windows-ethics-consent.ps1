Write-Host "Generating Consent form"

# Should be a copy of https://docs.google.com/document/d/1y4Gjx9cKh3-iXG3HsPghtEVKo4BujKWM166d1CoLIlw/edit
$FORM_VALUES='https://docs.google.com/document/d/1B3t8EirnEX6q94-1qLmb13czzleDNEWetXKEtND_Cxw/edit?usp=sharing'

# Get the CSS file first 
# TODO: Replace with path to gdoc2pdf\src\styles\no-h3-no-highlights.css
$CSS='C:\Users\chery\gdoc2pdf\src\styles\no-h3-no-highlights.css'

# The consent form template
$CONSENT='https://docs.google.com/document/d/1EffPq6GcAEmVJo29hvets215AY3NDxFcM8OahDiTwjk/edit'

gdoc2pdf -f $CONSENT -v $FORM_VALUES -o consent.pdf -c $CSS
