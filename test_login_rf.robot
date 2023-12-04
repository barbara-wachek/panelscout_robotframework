*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/pl
${LOGIN URL EN}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}        Chrome
${SIGNINBUTTON}        xpath=//*[@type='submit']
${EMAILINPUT}        xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}        xpath=//h5[contains(@class, 'h5')]
${DROPDOWN}        xpath=//*[@role='button']
${ENGLISH}        xpath=//*[@data-value='en']
${POLISH}        xpath=//ul/li[1]
${INVALID PASSWORD MESSAGE}        xpath=//*[text()='Identifier or password invalid.']
${LOGOUT}        xpath=//ul[contains(@class, 'padding')][2]/div[2]
${PLAYERS SECTION}        xpath=//*[text()='Gracze' or text()='Players']
${SEARCH FIELD}        xpath=//input
${NEXT SEARCHING PAGE}            xpath=//*[@id='pagination-next']
${URL}        

*** Test Cases ***
Log in to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert Dashboard
    [Teardown]    Close Browser

Select English
    Open login page
    Click on the dropdown list
    Select English language
    Assert Select Language English
    Capture Page Screenshot
    [Teardown]    Close Browser

Select Polish
    Open login page en
    Click on the dropdown list
    Select Polish language
    Assert Select Language Polish
    Capture Page Screenshot
    [Teardown]    Close Browser

Log in to the system with incorrect password
    Open login page
    Type in email
    Type in password wrong
    Click on the submit button
    Assert invalid password message
    [Teardown]    Close Browser
    
Log out from the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the log out button
    Assert logging out
    [Teardown]    Close Browser
    
Test search player by surname
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the Players section
    Type in surname and press enter
    Click on the next searching page button
    Assert Searching Page

#Dokończ przykład wyżej
    

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}        ${BROWSER}
Open login page en
    Open Browser    ${LOGIN URL EN}        ${BROWSER}
Type in email
    Input Text   ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text   ${PASSWORDINPUT}   Test-1234
Type in password wrong
    Input Text   ${PASSWORDINPUT}   Test-
Type in surname and press enter
    Wait Until Element Is Visible        ${SEARCH FIELD}
    Input Text    ${SEARCH FIELD}        Kowalski
    Press Keys    ${SEARCH FIELD}    ENTER
Click on the submit button
    Click Element        ${SIGNINBUTTON} 
Click on the dropdown list
    Click Element        ${DROPDOWN}
Click on the log out button
    Wait Until Element Is Visible        ${LOGOUT}
    Click Element        ${LOGOUT}  
Click on the Players section   
    Wait Until Element Is Visible        ${PLAYERS SECTION}
    Click Element        ${PLAYERS SECTION}
Click on the next searching page button
     Click Element        ${NEXT SEARCHING PAGE}
Select English language
    Click Element        ${ENGLISH}
Select Polish language
    Click Element        ${POLISH}
Assert Dashboard
    Wait Until Element Is Visible        ${PAGELOGO}
    Title Should Be     Scouts panel - zaloguj
    Capture Page Screenshot    alert.png
Assert Select Language English
    Wait Until Element Is Visible        ${PAGELOGO}
    Title Should Be        Scouts panel - sign in
    Capture Page Screenshot    test_select_english.png
Assert Select Language Polish
    Wait Until Element Is Visible        ${PAGELOGO}
    Title Should Be        Scouts panel - zaloguj
    Capture Page Screenshot    test_select_polish.png

Assert invalid password message
    Wait Until Element Is Visible        ${INVALID PASSWORD MESSAGE}
    Capture Page Screenshot    incorrect_password.png
    
Assert logging out
    Wait Until Element Is Visible        ${PAGELOGO}
    Capture Page Screenshot    logging_out.png

Assert Searching Page
    Wait Until Element Is Visible        ${PAGELOGO}
    Capture Page Screenshot    searching_player.png




