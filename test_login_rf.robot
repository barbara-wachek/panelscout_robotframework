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
${ADD PLAYER}        xpath=//*[@id='__next']/div[1]/main/div[3]/div[2]/div/div/a/button
${NAME}        xpath=//*[@name='name']
${SURNAME}        xpath=//*[@name='surname']
${DATE OF BIRTH}        xpath=//*[@name='age']
${MAIN POSITION}        xpath=//*[@name='mainPosition']
${SUBMIT PLAYER}        xpath=//*[@type='submit']
${ALERT SUCCESS ADDING PLAYER}        xpath=//div[contains(@class,'toast--success')]
${ALERT ERROR ADDING PLAYER}        xpath=//div[contains(@class,'toast--error')]
${CLEAR BUTTON}        xpath=//span[text()='Clear']/parent::button
${INPUT FIELDS}        xpath=//input[@value='']

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
    [Teardown]    Close Browser

Select Polish
    Open login page en
    Click on the dropdown list
    Select Polish language
    Assert Select Language Polish
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
#Do dokończenia (wyżej)

Add player with only required fields
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the Add player button
    Type in name
    Type in surname
    Type in date of birth
    Type in main position
    Submit player
    Assert success alert

Add player without one required field
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the Add player button
    Type in name
    Type in surname
    Type in date of birth
    Submit player 
    Assert block adding alert
    
Add player clear form button
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the Add player button
    Type in name
    Type in surname
    Type in date of birth
    Click on the clear button

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
Type in name
    Wait Until Element Is Visible        ${NAME}  
    Input Text        ${NAME}         Jan
Type in surname 
    Input Text        ${SURNAME}         Kowalski
Type in date of birth 
    Input Text        ${DATE OF BIRTH}          05.02.2000
Type in main position
    Input Text        ${MAIN POSITION}         napastnik
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
Click on the Add player button
    Wait Until Element Is Visible        ${ADD PLAYER}
    Click Element        ${ADD PLAYER}
Click on the clear button
    Click Element        ${CLEAR BUTTON}
    Wait Until Element Does Not Contain        ${INPUT FIELDS}        Should Not Be Equal As Strings
    Capture Page Screenshot    clear.png
Submit player
    Click Element        ${SUBMIT PLAYER}           
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
Assert success alert
    Wait Until Element Is Visible        ${ALERT SUCCESS ADDING PLAYER}
    Capture Page Screenshot    adding_player_success.png
Assert error alert
    Wait Until Element Is Visible        ${ALERT ERROR ADDING PLAYER}
    Capture Page Screenshot    adding_player_error.png
Assert block adding alert
    Element Should Not Be Visible        ${ALERT SUCCESS ADDING PLAYER}
    Capture Page Screenshot    adding_player_block.png



