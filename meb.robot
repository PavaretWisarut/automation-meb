*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ${CURDIR}/meb_locator.robot
Variables    ${CURDIR}/testdata.yaml

*** Keywords ***
Open meb browser
    [Arguments]     ${browser_url}=${meb_browser}
    SeleniumLibrary.Open browser    ${browser_url}      browser=gc  
    SeleniumLibrary.Maximize Browser Window

Close pop up modal
    BuiltIn.Sleep   2s
    SeleniumLibrary.Wait until element is visible   ${meb_locator['close_popup_modal']}
    SeleniumLibrary.Click element   ${meb_locator['close_popup_modal']}
    
Input book search and press enter
    [Arguments]     ${search}
    SeleniumLibrary.Wait until element is visible   ${meb_locator['ip_search_bar']}
    SeleniumLibrary.input text      ${meb_locator['ip_search_bar']}     ${search}
    SeleniumLibrary.press Keys      ${meb_locator['ip_search_bar']}     ENTER

Verify book is displayed with expected name
    [Arguments]     ${expected_name}
    ${new_locator}=     String.Replace string   ${meb_locator['lbl_verify_book_is_visible']}    @#name@#    ${expected_name}
    SeleniumLibrary.Wait until element is visible   ${new_locator}

Close meb browser
    SeleniumLibrary.Close browser

*** Test Cases ***
Test : open meb browser and verify diplayed is correct as expected
    [Tags]  meb browser
    open meb browser
    Close pop up modal
    Input book search and press enter   ${my_hero_book}
    Verify book is displayed with expected name     ${my_hero_book}
    Close meb browser
        
