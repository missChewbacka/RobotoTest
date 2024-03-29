*** Settings ***

Resource    Variables.robot
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime

*** Keywords ***

Setup Chrome Webdriver
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --start-maximized
    Open Browser    https://pre.bonp.me//member    chrome    options=${options}   executable_path=C:\Users\Professional\PycharmProjects\RobotDemo\drivers\chromedriver.exe
    #Set Window Size    1936    1056
    Set Selenium Implicit Wait    15s

Setup Firefox Webdriver
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --start-maximized
    Open Browser    https://pre.bonp.me//member    firefox    options=${options}   executable_path=C:\Users\Professional\Downloads\geckodriver-v0.34.0-win-aarch64
    Set Window Size    1445    875
    Set Selenium Implicit Wait    15s

Login
    [Arguments]    ${username}    ${password}
    Go To    ${environment}
    Wait Until Element Is Visible and Enabled    ${email_input}
    Input Text    ${email_input}    ${username}
    Wait Until Element Is Visible and Enabled    ${pass_input}
    Input Text    ${pass_input}    ${password}
    Wait Until Element Is Visible and Enabled    ${submit_button}
    Click Button    ${submit_button}

Open Specified Bot
    [Arguments]    ${table_locator}    ${target_text}
    Wait Until Element Is Visible and Enabled   ${table_locator}
    ${table_elements}    Get WebElements    ${table_locator}//td
    FOR    ${cell_element}    IN    @{table_elements}
        ${cell_text}    Get Text    ${cell_element}
        Run Keyword If    '${target_text}' in '${cell_text}'    Click Element    ${cell_element}
        Exit For Loop If    '${target_text}' in '${cell_text}'   # Exit the loop if the text is found
    END
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s

Open Bot 1
    [Arguments]   ${my_bot_name}   ${my_locator}
    Wait Until Element Is Visible and Enabled   ${my_locator}
    ${elements}    Get WebElements    ${my_locator}
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Run Keyword If    '${my_bot_name}' in '${text}'    Click Element    ${element}
    END
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s

Click Element with Specified Text
    [Arguments]   ${my_elements_locator}   ${target_text}
    ${elements}    Get WebElements    ${my_elements_locator}
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Run Keyword If    '${target_text}' in '${text}'    Click Element    ${element}
    END


Wait Until Element Is Visible and Enabled
    [Arguments]    ${locator}    ${timeout}=40s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Wait Until Element Is Enabled    ${locator}    timeout=${timeout}

Select Option With Specified Text
    [Arguments]    ${table_xpath}    ${expected_text}    ${timeout}=30s
    ${cell_list} =    Get WebElements    ${table_xpath}
    FOR    ${cell}    IN    @{cell_list}
        ${cell_text} =    Get Text    ${cell}
        Run Keyword If    '${expected_text}' in '${cell_text}'    Click Element    ${cell}
        Exit For Loop
        Wait Until Page Contains    ${expected_text}    ${timeout}=30s
        Log    Clicked cell with text '${expected_text}'
    END

Type In And Press Enter
    [Arguments]   ${locator}   ${text}
    Input Text    ${new_group_name}    ${text}
    Press Keys    ${new_group_name}    ENTER

Clear, Type In And Press Enter
    [Arguments]   ${locator}   ${text}
    ${attribute_value}=    Get Element Attribute   ${new_item_name}    data-value
    ${text_length}=    Get Length    ${attribute_value}
    FOR    ${i}    IN RANGE    ${text_length}
        Press Keys    ${new_item_name}    BACKSPACE
    END
    Input Text    ${new_item_name}    ${text}
    Press Keys    ${new_item_name}    ENTER

Send Broadcast and Verify Success
    [Arguments]    ${element_locator}   ${success_message}
    Click Element    ${element_locator}
    Click Button    ${send_broadcast}
    Wait Until Element Is Visible    ${success_sending_message}    timeout=5s
    ${actual_message}    Get Text    ${success_sending_message}
    Should Be Equal As Strings    ${actual_message}    ${success_message}
    Click Element    ${close_popup_icon}
    Wait Until Element Is Not Visible    ${success_sending_message}    timeout=5s

*** Test Cases ***

send textitem1 broadcast

    ${test_bot}   Set Variable   Sasha-240131-brv2-api10
    ${bot_names_list}   Set Variable    //table[@class='list-view']
    ${success_message}    Set Variable   Broadcasting request has been submitted and is now processing.

    [Documentation]    This test sends a broadcast message (textitem1) to all users using regular broadcasting functionality.
    [Tags]   New App Popup   API1.0   Regression   Broadcast   Demo

    [Setup]    Setup Firefox Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Specified Bot   ${bot_names_list}   ${test_bot}
    [Teardown]    Close Browser

    Wait Until Element Is Not Visible    ${loader_screen}   timeout=5s
    Wait Until Element Is Visible   ${users_tab}   timeout=5s
    Click Element   ${users_tab}
    Wait Until Element Is Not Visible    ${loader_screen}   timeout=5s
    Wait Until Element Is Visible and Enabled    ${broadcast_button}  timeout=5s
    Click Button    ${broadcast_button}
    Wait Until Element Is Visible and Enabled    ${broadcast_popup}   timeout=5s
    Click Element    ${group1}
    Send Broadcast and Verify Success    ${textitem1_br}   ${success_message}
    Send Broadcast and Verify Success    ${textitem2_br}   ${success_message}
    Send Broadcast and Verify Success    ${carousel1_br}   ${success_message}
    Send Broadcast and Verify Success    ${carousel2_br}   ${success_message}
    Send Broadcast and Verify Success    ${image_carousel_br}   ${success_message}
    Send Broadcast and Verify Success    ${flex_message_br}   ${success_message}
    Send Broadcast and Verify Success    ${image_map_br}   ${success_message}
    Send Broadcast and Verify Success    ${image1_br}   ${success_message}
    Send Broadcast and Verify Success    ${video1_br}   ${success_message}