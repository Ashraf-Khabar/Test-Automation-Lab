*** Settings ***
Documentation    Login Functionality Tests
Variables        ../test_data/test_data.py
Library          SeleniumLibrary
Suite Setup      Open Browser To Login Page
Suite Teardown   Close All Browsers
Test Template    Login With Credentials

*** Variables ***
${LOGIN_URL}      https://www.saucedemo.com/
${BROWSER}        chrome

*** Test Cases ***              USERNAME                 PASSWORD
Valid Credentials              ${VALID_USER['username']}   ${VALID_USER['password']}

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens browser to login page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5 seconds
    Login Page Should Be Open

Login Page Should Be Open
    [Documentation]    Verifies login page is displayed
    Page Should Contain Element    id:user-name
    Page Should Contain Element    id:password
    Page Should Contain Element    id:login-button

Login With Credentials
    [Arguments]    ${username}    ${password}
    [Documentation]    Attempts to login with given credentials
    Input Text      id:user-name  ${username}
    Input Password  id:password    ${password}
    Click Button    id:login-button
    
    Run Keyword If    '${username}' == '${VALID_USER['username']}' and '${password}' == '${VALID_USER['password']}'
    ...    Valid Login Should Succeed
    ...    ELSE
    ...    Invalid Login Should Fail

Valid Login Should Succeed
    [Documentation]    Verifies successful login
    Page Should Contain    Swag Labs
    
Invalid Login Should Fail
    [Documentation]    Verifies login failed
    Page Should Contain    Login failed
    Location Should Be     ${LOGIN_URL}