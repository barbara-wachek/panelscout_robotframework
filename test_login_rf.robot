*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/pl
${BROWSER}        Chrome
${SIGNINBUTTON}        xpath=//*[@type='submit']
${EMAILINPUT}        xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}        xpath=//h5[contains(@class, 'h5')]

*** Test Cases ***
Log in to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}        ${BROWSER}
Type in email
    Input Text   ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text   ${PASSWORDINPUT}   Test-1234
Click on the submit button
    Click Element        ${SIGNINBUTTON} 
Assert dashboard
    Wait Until Element Is Visible        ${PAGELOGO}
    Title Should Be     Scouts panel - zaloguj
    Capture Page Screenshot    alert.png



