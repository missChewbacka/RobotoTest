*** Settings ***

Resource    Variables.robot
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime

*** Variables ***

#Bot Names
${my_api10_bot_name}   test1
${my_api20_bot_name}   test2
#Login Page
${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
${environment}   https://pre.bonp.me//member
${email_input}   //input[@name='email']
${pass_input}   //input[@name='pass']
${submit_button}   //button[@type='text']
&{credentials}    email=alexandra@evolany.com    password=221373897221373897qW!
#New APP popup
${new_app_button}   //button[text()[contains(.,'New App')]]
${new_bot_name}   //input[@name='name']
@{checkbox_values}   crm    events    coupons    catalog    rms    chat    ec    mail    stores    campaign    elgana    g_events    bot_posts    user_logs    linepoints    sfa_salesforce    sfa_hubspot    lp    stamp_card    ms365    files
${company_name_input_field}   //input[@target_name='com_id']
${company_name_options}   //ul[@id='form-item-autocomplete']/li
${company_name_option}   (//ul[@id='form-item-autocomplete']/li)[1]
${save_bot_settings}   //button[@class='icon save']
${locator}   //button[@class='tooltip icon new deploy']
${bot_option_list}   //td[@class='list-item-name']
#APP tab
${expand_top_menu}   //a[@class='miniapps icon dots-v']
${top_menu_option_list}   //nav[@class='btns app-menus']/a
${expand_top_menu_option_list}   //section[@class='submenus']
${events_tab}   (//section[@class='submenus']/ul/li)[2]
${loader_screen}    //article[@id='mask']
#Events tab
${new_event_button}   //button[@class='new icon plus-square']
${new_event_editing_popup}   //section[@class='white popup event_edit_view']
${event_link}   //input[@name='linkto']
${evant_image}   //div[@class='form-type-file']/div/div/input
${event_title}   //input[@name='title']
${event_description}   //textarea[@name='desc']
${event_application_start}   //div[@class='form-item-datetime-picker dt-picker-box']/input[@placeholder='Start at']
${event_seats}   //input[@name='seats']
${save_settings_button}   //button[@class='icon save']
${confirm_popup}   //div[@class='popup window']
${confirm_save}   //footer/button
#Chatflow tab
${chatflow_tab}   //dd[@name='navi-flow']
${add_new_group}   (//button[@class='icon plus-square'])[1]
${new_group}   //dd[@class='new-group']
${new_group_name}   //li[@class='group_0 editing on']//input[@type='text']
${group1}   //h5[normalize-space()='group1']
${add_new_item}   (//button[@class='icon plus-square'])[2]
${item_text}   //dd[@rt='text']
${item_text_textarea}   (//textarea[@class='msg with-emoticon'])[1]
${new_item_name}   //input[@type='text']
${item_card}   //dd[@rt='card']
${item_imagecard}   //dd[@rt='imagecard']
${item_imagemap}   //dd[@rt='imagemap']
${item_image}   //dd[@rt='image']
${item_video}   //dd[@rt='video']
${item_conditional}   //dd[@rt='logical']
${item_flex}   //dd[@rt='flex']
${big_button_name_input_field}   //div[@class='form-type-text']/input[@name='label']
${save_button_settings}   //button[@class='icon save label']

#Broadcast
${users_tab}   //a[@name='user_list_view']
${broadcast_button}   //button[@id='btn_broadcast']
${broadcast_popup}   //section[@class='broadcasting']
${group1_br}   (//ul[@class='groups']/li)[4]
${textitem1_br}   //h5[normalize-space()='textitem1']
${send_broadcast}   //button[@class='icon send label']
${sucess_sending_message}    //div[@class='content']/p

*** Keywords ***

Setup Webdriver
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    #Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --start-maximized
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${options}
    Set Selenium Implicit Wait    60s

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

*** Test Cases ***

send textitem1 broadcast

    ${test_bot}   Set Variable   Sasha-240124-brv2-api20
    ${bot_names_list}   Set Variable    //table[@class='list-view']

    [Documentation]    This test sends a broadcast message (textitem1) to all users using regular broadcasting functionality.
    [Tags]   New App Popup   API1.0   Regression   Broadcast   Demo
    [Setup]    Setup Webdriver
               Login   ${credentials}[email]   ${credentials}[password]
               Open Specified Bot   ${bot_names_list}   ${test_bot}
    [Teardown]    Close Browser

    Wait Until Element Is Not Visible    ${loader_screen}   timeout=5s
    Wait Until Element Is Visible and Enabled   ${users_tab}   timeout=5s
    Click Element   ${users_tab}
    Wait Until Element Is Visible and Enabled    ${broadcast_button}  timeout=5s
    Click Button    ${broadcast_button}
    Wait Until Element Is Visible and Enabled    ${broadcast_popup}   timeout=5s
    Click Element    ${group1}
    Wait Until Element Is Visible and Enabled    ${textitem1_br}
    Click Element    ${textitem1_br}
    Click Button    ${send_broadcast}
    #Verification: check if the 'Broadcasting request has been submitted and is now processing.' is displayed.
    Wait Until Element Is Visible    ${sucess_sending_message}   timeout=10s
    ${actual_message}    Get Text    ${sucess_sending_message}
    Should Be Equal As Strings    ${actual_message}   Broadcasting request has been submitted and is now processing.
