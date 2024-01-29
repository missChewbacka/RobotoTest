*** Settings ***

Resource    Variables.robot
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime

*** Keywords ***

Setup Webdriver
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --start-maximized
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Open Browser    https://pre.bonp.me//member    chrome    options=${options}
    Set Window Size    1980    1080
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

Open Bot
    [Arguments]   ${my_bot_name}
    Wait Until Element Is Visible and Enabled   ${bot_option_list}
    Select Option With Specified Text    ${bot_option_list}    ${my_bot_name}
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s

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

*** Test Cases ***

create API1.0 bot

    ${checkbox_values}=    Create List    crm    events    coupons    catalog    rms    chat    ec    mail    stores    campaign    elgana    g_events    bot_posts    user_logs    linepoints    sfa_salesforce    sfa_hubspot    lp    stamp_card    ms365    files
    ${my_company_name}   Set Variable   Evolany Co., Ltd.

    [Documentation]    This test creates a BR V2 API1.0 bot under Evolany Co., Ltd. company
    [Tags]   New App Popup   API1.0   Regression Test1   Test2
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
    [Teardown]    Close Browser

    Wait Until Element Is Visible and Enabled    ${new_app_button}
    Click Button   ${new_app_button}
    #input bot name
    Wait Until Element Is Visible and Enabled  ${new_bot_name}
    Input Text   ${new_bot_name}    ${my_api10_bot_name}
    #check all bot moduls except ChatGPT
    FOR    ${value}    IN    @{checkbox_values}
        Run Keyword If    '${value}' != 'chatgpt'    Click Element    //input[@value='${value}']
    END
    #select plan option
    Select Radio Button   plan   pro
    #select API1.0 option
    Select Radio Button   apiver   1
    #enter Company name
    Wait Until Element Is Visible and Enabled   ${company_name_input_field}
    Click Element    ${company_name_input_field}
    Sleep    1s
    Input Text    ${company_name_input_field}    ${my_company_name}
    Sleep   1s
    Wait Until Element Is Visible and Enabled   ${company_name_option}
    Click Element    ${company_name_option}
    #save new bot
    Wait Until Element Is Visible and Enabled   ${save_bot_settings}
    Click Button    ${save_bot_settings}
    #Verification
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s
    Wait Until Element Is Visible and Enabled   ${locator}

create API2.0 bot

    ${checkbox_values}=    Create List    crm    events    coupons    catalog    rms    chat    ec    mail    stores    campaign    elgana    g_events    bot_posts    user_logs    linepoints    sfa_salesforce    sfa_hubspot    lp    stamp_card    ms365    files
    ${my_company_name}   Set Variable   Evolany Co., Ltd.

    [Documentation]    This test creates a BR V2 API2.0 bot under Evolany Co., Ltd. company
    [Tags]   New App Popup   API2.0   Regression
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
    [Teardown]    Close Browser

    Wait Until Element Is Visible and Enabled    ${new_app_button}
    Click Button   ${new_app_button}
    #input bot name
    Wait Until Element Is Visible and Enabled  ${new_bot_name}
    Input Text   ${new_bot_name}    ${my_api20_bot_name}
    #check all bot moduls except ChatGPT
    FOR    ${value}    IN    @{checkbox_values}
        Run Keyword If    '${value}' != 'chatgpt'    Click Element    //input[@value='${value}']
    END
    #select plan option
    Select Radio Button   plan   pro
    #select API1.0 option
    Select Radio Button   apiver   2
    #enter Company name
    Wait Until Element Is Visible and Enabled   ${company_name_input_field}
    Click Element    ${company_name_input_field}
    Input Text    ${company_name_input_field}    ${my_company_name}
    Wait Until Element Is Visible and Enabled   ${company_name_option}
    Click Element    ${company_name_option}
    #save new bot
    Wait Until Element Is Visible and Enabled   ${save_bot_settings}
    Click Button    ${save_bot_settings}
    #Verification
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s
    Wait Until Element Is Visible and Enabled   ${locator}

add Events to API1.0 bot

    ${event_link_list}=   Create List   https://www.udemy.com/   https://www.netflix.com/   https://soundcloud.com/
    ${event_title_list}=    Create List   Test Event1   Test Event2   Test Event3
    ${event1_image}   Set Variable   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img1.jpg
    ${event2_image}   Set Variable   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img2.jpg
    ${event3_image}   Set Variable   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img3.jpg
    ${description}   Set Variable   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae arcu turpis. Morbi quis dignissim nunc, nec luctus nibh. In luctus porttitor posuere. Quisque.
    ${seats}   Set Variable   1

    [Documentation]    This test adds 3 events (event1 and event2 application period has already started) to a BR V2 API1.0 bot
    [Tags]   Events Tab   API1.0   Regression
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Wait Until Element Is Visible and Enabled   ${expand_top_menu}
    Click Element    ${expand_top_menu}
    Wait Until Element Is Visible and Enabled   ${events_tab}
    Click Element    ${events_tab}
    #Event1
    Wait Until Element Is Visible and Enabled    ${new_event_button}
    Click Button   ${new_event_button}
    Wait Until Element Is Visible and Enabled    ${new_event_editing_popup}
    Input Text    ${event_link}    ${event_link_list}[0]
    Choose File   ${evant_image}   ${event1_image}
    Input Text    ${event_title}   ${event_title_list}[0]
    Input Text    ${event_description}   ${description}
    ${current_date}    Get Current Date    result_format=%Y-%m-%d
    ${result_date_and_time} =    Set Variable    ${current_date} 10:00
    Clear Element Text   ${event_application_start}
    Input Text   ${event_application_start}   ${result_date_and_time}
    Input Text    ${event_seats}   ${seats}
    Click Button   ${save_settings_button}
    Wait Until Page Contains Element   ${confirm_popup}   timeout=20s
    Click Element    ${confirm_save}
    #Event2
    Wait Until Element Is Visible and Enabled    ${new_event_button}
    Click Button   ${new_event_button}
    Wait Until Element Is Visible and Enabled    ${new_event_editing_popup}
    Input Text    ${event_link}    ${event_link_list}[1]
    Choose File   ${evant_image}   ${event2_image}
    Input Text    ${event_title}   ${event_title_list}[1]
    Input Text    ${event_description}   ${description}
    ${current_date}    Get Current Date    result_format=%Y-%m-%d
    ${result_date_and_time} =    Set Variable    ${current_date} 10:00
    Clear Element Text   ${event_application_start}
    Input Text   ${event_application_start}   ${result_date_and_time}
    Input Text    ${event_seats}   ${seats}
    Click Button   ${save_settings_button}
    Wait Until Page Contains Element   ${confirm_popup}   timeout=20s
    Click Element    ${confirm_save}
    #Event3
    Wait Until Element Is Visible and Enabled    ${new_event_button}
    Click Button   ${new_event_button}
    Wait Until Element Is Visible and Enabled    ${new_event_editing_popup}
    Input Text    ${event_link}    ${event_link_list}[2]
    Choose File   ${evant_image}   ${event3_image}
    Input Text    ${event_title}   ${event_title_list}[2]
    Input Text    ${event_description}   ${description}
    Input Text    ${event_seats}   ${seats}
    Click Button   ${save_settings_button}
    Wait Until Page Contains Element   ${confirm_popup}   timeout=20s
    Click Element    ${confirm_save}

add Events to API1.0 bot

    ${event_link_list}=   Create List   https://www.udemy.com/   https://www.netflix.com/   https://soundcloud.com/
    ${event_title_list}=    Create List   Test Event1   Test Event2   Test Event3
    ${event1_image}   Set Variable   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img1.jpg
    ${event2_image}   Set Variable   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img2.jpg
    ${event3_image}   Set Variable   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img3.jpg
    ${description}   Set Variable   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae arcu turpis. Morbi quis dignissim nunc, nec luctus nibh. In luctus porttitor posuere. Quisque.
    ${seats}   Set Variable   1

    [Documentation]    This test adds 3 events (event1 and event2 application period has already started) to a BR V2 API2.0 bot
    [Tags]   Events Tab   API1.0   Regression
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Wait Until Element Is Visible and Enabled   ${expand_top_menu}
    Click Element    ${expand_top_menu}
    Wait Until Element Is Visible and Enabled   ${events_tab}
    Click Element    ${events_tab}
    Wait Until Element Is Visible and Enabled   ${expand_top_menu}
    Click Element    ${expand_top_menu}
    Wait Until Element Is Visible and Enabled   ${events_tab}
    Click Element    ${events_tab}
    #Event1
    Wait Until Element Is Visible and Enabled    ${new_event_button}
    Click Button   ${new_event_button}
    Wait Until Element Is Visible and Enabled    ${new_event_editing_popup}
    Input Text    ${event_link}    ${event_link_list}[0]
    Choose File   ${evant_image}   ${event1_image}
    Input Text    ${event_title}   ${event_title_list}[0]
    Input Text    ${event_description}   ${description}
    ${current_date}    Get Current Date    result_format=%Y-%m-%d
    ${result_date_and_time} =    Set Variable    ${current_date} 10:00
    Clear Element Text   ${event_application_start}
    Input Text   ${event_application_start}   ${result_date_and_time}
    Input Text    ${event_seats}   ${seats}
    Click Button   ${save_settings_button}
    Wait Until Page Contains Element   ${confirm_popup}   timeout=20s
    Click Element    ${confirm_save}
    #Event2
    Wait Until Element Is Visible and Enabled    ${new_event_button}
    Click Button   ${new_event_button}
    Wait Until Element Is Visible and Enabled    ${new_event_editing_popup}
    Input Text    ${event_link}    ${event_link_list}[1]
    Choose File   ${evant_image}   ${event2_image}
    Input Text    ${event_title}   ${event_title_list}[1]
    Input Text    ${event_description}   ${description}
    ${current_date}    Get Current Date    result_format=%Y-%m-%d
    ${result_date_and_time} =    Set Variable    ${current_date} 10:00
    Clear Element Text   ${event_application_start}
    Input Text   ${event_application_start}   ${result_date_and_time}
    Input Text    ${event_seats}   ${seats}
    Click Button   ${save_settings_button}
    Wait Until Page Contains Element   ${confirm_popup}   timeout=20s
    Click Element    ${confirm_save}
    #Event3
    Wait Until Element Is Visible and Enabled    ${new_event_button}
    Click Button   ${new_event_button}
    Wait Until Element Is Visible and Enabled    ${new_event_editing_popup}
    Input Text    ${event_link}    ${event_link_list}[2]
    Choose File   ${evant_image}   ${event3_image}
    Input Text    ${event_title}   ${event_title_list}[2]
    Input Text    ${event_description}   ${description}
    Input Text    ${event_seats}   ${seats}
    Click Button   ${save_settings_button}
    Wait Until Page Contains Element   ${confirm_popup}   timeout=20s
    Click Element    ${confirm_save}

adding group1 to api1.0 bot

    ${my_group_name}   Set Variable   group1
    ${my_item_name}=   Create List   textitem1   textitem2   textitem3   textitem4    carousel1   carousel2   image_carousel   flex_message   image_map   image1   video1   conditional
    ${my_item_text}=   Create List   text1   text2   text3   text4
    ${my_item_textarea_locator}=   Create List   (//textarea[@class='msg with-emoticon'])[1]   (//textarea[@class='msg with-emoticon'])[2]   (//textarea[@class='msg with-emoticon'])[3]   (//textarea[@class='msg with-emoticon'])[4]

    [Documentation]    This test adds group1 to a BR V2 API1.0 bot

    [Tags]   App Tab   API1.0   Regression   Test2
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Click Element   ${chatflow_tab}
    Wait Until Element Is Visible and Enabled    ${add_new_group}
    Mouse Over    ${add_new_group}
    Wait Until Element Is Visible and Enabled    ${new_group}
    Click Element    ${new_group}
    Wait Until Element Is Visible and Enabled   ${new_group_name}
    Type In And Press Enter    ${new_group_name}    ${my_group_name}
    Wait Until Element Is Visible and Enabled    ${group1}
    #group1 item1
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[0]
    Click Element    ${my_item_textarea_locator}[0]
    Input Text    ${my_item_textarea_locator}[0]    ${my_item_text}[0]
    Press Keys   ${my_item_textarea_locator}[0]   ENTER
    #group1 item2
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[1]
    Click Element    ${my_item_textarea_locator}[1]
    Input Text    ${my_item_textarea_locator}[1]    ${my_item_text}[1]
    Press Keys   ${my_item_textarea_locator}[1]   ENTER
    #group1 item3
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[2]
    Click Element    ${my_item_textarea_locator}[2]
    Input Text    ${my_item_textarea_locator}[2]    ${my_item_text}[2]
    Press Keys   ${my_item_textarea_locator}[2]   ENTER
    #group1 item4
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[3]
    Click Element    ${my_item_textarea_locator}[3]
    Input Text    ${my_item_textarea_locator}[3]    ${my_item_text}[3]
    Press Keys   ${my_item_textarea_locator}[3]   ENTER

Creating a new chat group

    ${my_group_name}   Set Variable   group1

    [Documentation]    This test adds group1 to a BR V2 API1.0 bot

    [Tags]   App Tab   API1.0   Regression   Test1
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Click Element   ${chatflow_tab}
    Wait Until Element Is Visible and Enabled    ${add_new_group}
    Mouse Over    ${add_new_group}
    Wait Until Element Is Visible and Enabled    ${new_group}
    Click Element    ${new_group}
    Wait Until Element Is Visible and Enabled   ${new_group_name}
    Type In And Press Enter    ${new_group_name}    ${my_group_name}
    Wait Until Element Is Visible and Enabled    ${group1}

Creating text items (actions)

    ${my_item_name}=   Create List   textitem1   textitem2   textitem3   textitem4

    [Documentation]    This test adds textitem1, textitem2, textitem3, textitem4 text actions to a group1
    [Tags]   App Tab   API1.0   Regression   Test1
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Click Element   ${chatflow_tab}
    Wait Until Element Is Visible and Enabled    ${add_new_group}
    #group1 textitem1
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[0]
    #group1 textitem2
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[1]
    #group1 textitem3
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[2]
    #group1 textitem4
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled   ${add_new_item}
    Mouse Over    ${add_new_item}
    Wait Until Element Is Visible and Enabled   ${item_text}
    Click Element    ${item_text}
    Wait Until Element Is Visible and Enabled   ${new_item_name}
    Click Element    ${new_item_name}
    Clear, Type In And Press Enter    ${new_item_name}    ${my_item_name}[3]

Entering text in the text field

    ${my_item_text}=   Create List   text1   text2   text3   text4
    ${my_item_textarea_locator}=   Create List   (//textarea[@class='msg with-emoticon'])[1]   (//textarea[@class='msg with-emoticon'])[2]   (//textarea[@class='msg with-emoticon'])[3]   (//textarea[@class='msg with-emoticon'])[4]

    [Documentation]    This test enters "text1"-"text4" in the text fields of the created text items
    [Tags]   App Tab   API1.0   Regression   Test1
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Click Element   ${chatflow_tab}
    Wait Until Element Is Visible and Enabled    ${add_new_group}
    #textitem1 text
    Click Element    ${group1}
    Click Element    ${my_item_textarea_locator}[0]
    Input Text    ${my_item_textarea_locator}[0]    ${my_item_text}[0]
    Press Keys   ${my_item_textarea_locator}[0]   ENTER
    #textitem2 text
    Click Element    ${group1}
    Click Element    ${my_item_textarea_locator}[1]
    Input Text    ${my_item_textarea_locator}[1]    ${my_item_text}[1]
    Press Keys   ${my_item_textarea_locator}[1]   ENTER
    #textitem3 text
    Click Element    ${group1}
    Click Element    ${my_item_textarea_locator}[2]
    Input Text    ${my_item_textarea_locator}[2]    ${my_item_text}[2]
    Press Keys   ${my_item_textarea_locator}[2]   ENTER
    #textitem4 text
    Click Element    ${group1}
    Click Element    ${my_item_textarea_locator}[3]
    Input Text    ${my_item_textarea_locator}[3]    ${my_item_text}[3]
    Press Keys   ${my_item_textarea_locator}[3]   ENTER

Adding a "big" button to a text item (textitem1)

    ${my_big_button_text}  Set Variable   text1 button
    ${my_big_button_location}   Set Variable   (//li[@tp='items'])[1]
    ${my_new_big_button}   Set Variable   (//ol[@class='card rt-text']/li[@tp='items'])[1]

    [Documentation]    This test adds "text1 button" to textitem1 chatflow action.
    [Tags]   App Tab   API1.0   Regression   Test1
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Bot   ${my_api10_bot_name}
    [Teardown]    Close Browser

    Click Element   ${chatflow_tab}
    Wait Until Element Is Visible and Enabled    ${add_new_group}
    #textitem1 "big" button
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled    ${my_big_button_location}
    Click Element    ${my_big_button_location}
    Wait Until Element Is Visible and Enabled    ${big_button_name_input_field}
    Clear Element Text   ${big_button_name_input_field}
    Input Text   ${big_button_name_input_field}   ${my_big_button_text}
    Click Button    ${save_button_settings}
    # Check if the element contains the expected text
    Run Keyword If    ${my_big_button_text} in ${my_new_big_button}    Log    Test Passed
    Run Keyword Unless    ${my_big_button_text} ${my_new_big_button}    Fail    Test Failed
    #Wait Until Keyword Succeeds    10s    1s    Element Should Contain    ${my_new_big_button}    ${my_big_button_text}

send textitem1 broadcast jenkins

    ${test_bot}   Set Variable   Sasha-240124-brv2-api20
    ${bot_names_list}   Set Variable    //table[@class='list-view']
    ${3dots}   Set Variable   //a[@class='miniapps icon dots-v badge']
    ${userstab}   Set Variable   (//section[@class='submenus']//li)[1]

    [Documentation]    This test sends a broadcast message (textitem1) to all users using regular broadcasting functionality.
    [Tags]   New App Popup   API1.0   Regression   Broadcast   Demo_test
    [Setup]    Setup Webdriver
    [Teardown]    Close Browser

    Wait Until Element Is Visible and Enabled    ${email_input}
    Input Text    ${email_input}    ${credentials}[email]
    Wait Until Element Is Visible and Enabled    ${pass_input}
    Input Text    ${pass_input}    ${credentials}[password]
    Wait Until Element Is Visible and Enabled    ${submit_button}
    Click Button    ${submit_button}
    ${size} =    Get Window Size
    Log    Current Window Size: ${size}
    Execute JavaScript    window.resizeTo(1980, 1080)
    ${new_size} =    Get Window Size
    Log    New Window Size: ${new_size}
    Click Button    ${send_broadcast}
    Wait Until Element Is Visible and Enabled   ${bot_names_list}
    ${table_elements}    Get WebElements    ${bot_names_list}//td
    FOR    ${cell_element}    IN    @{table_elements}
        ${cell_text}    Get Text    ${cell_element}
        Run Keyword If    '${test_bot}' in '${cell_text}'    Click Element    ${cell_element}
        Exit For Loop If    '${test_bot}' in '${cell_text}'   # Exit the loop if the text is found
    END
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s
    Wait Until Element Is Visible and Enabled   ${3dots}
    Click Element    ${3dots}
    Wait Until Element Is Visible and Enabled   ${users_tab}
    Click Element   ${users_tab}
    Wait Until Element Is Visible and Enabled    ${broadcast_button}  timeout=5s
    Click Button    ${broadcast_button}
    Wait Until Element Is Visible and Enabled    ${broadcast_popup}   timeout=5s
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled    ${textitem1_br}
    Click Element    ${textitem1_br}
    #Verification: check if the 'Broadcasting request has been submitted and is now processing.' is displayed.
    Wait Until Element Is Visible    ${sucess_sending_message}   timeout=10s
    ${actual_message}    Get Text    ${sucess_sending_message}
    Should Be Equal As Strings    ${actual_message}   Broadcasting request has been submitted and is now processing.

Check Screen Size

    ${test_bot}   Set Variable   Sasha-240124-brv2-api20
    ${bot_names_list}   Set Variable    //table[@class='list-view']

    [Setup]    Setup Webdriver
    [Tags]   Screensize
    [Teardown]    Close Browser

    Wait Until Element Is Visible and Enabled    ${email_input}
    Input Text    ${email_input}    ${credentials}[email]
    Wait Until Element Is Visible and Enabled    ${pass_input}
    Input Text    ${pass_input}    ${credentials}[password]
    Wait Until Element Is Visible and Enabled    ${submit_button}
    Click Button    ${submit_button}
    Wait Until Element Is Visible and Enabled   ${bot_names_list}
    ${table_elements}    Get WebElements    ${bot_names_list}//td
    FOR    ${cell_element}    IN    @{table_elements}
        ${cell_text}    Get Text    ${cell_element}
        Run Keyword If    '${test_bot}' in '${cell_text}'    Click Element    ${cell_element}
        Exit For Loop If    '${test_bot}' in '${cell_text}'   # Exit the loop if the text is found
    END
    Wait Until Page Does Not Contain Element    ${loader_screen}   timeout=30s
    ${size} =    Get Window Size
    Log    Current Window Size: ${size}
    Set Window Size   1920   1080
    ${new_size} =    Get Window Size
    Log    New Window Size: ${new_size}
    # Other test steps go here
    Close Browser