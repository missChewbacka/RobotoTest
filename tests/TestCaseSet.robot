*** Settings ***

Library    SeleniumLibrary

*** Variables ***

#Login Page
${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
${environment}   https://pre.bonp.me//member
${email_input}   //input[@name='email']
${pass_input}   //input[@name='pass']
${submit_button}   //button[@type='text']
&{credentials}    email=alexandra@evolany.com    password=221373897221373897qW!
#New APP
${new_app_button}   //button[text()[contains(.,'New App')]]
${new_bot_name}   //input[@name='name']
@{checkbox_values}   crm    events    coupons    catalog    rms    chat    ec    mail    stores    campaign    elgana    g_events    bot_posts    user_logs    linepoints    sfa_salesforce    sfa_hubspot    lp    stamp_card    ms365    files
${company_name_input_field}   //input[@target_name='com_id']
${company_name_options}   //ul[@id='form-item-autocomplete']/li
${company_name_option}   (//ul[@id='form-item-autocomplete']/li)[1]
${save_bot_settings}   //button[@class='icon save']



*** Keywords ***

Setup Webdriver
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --start-maximized
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${options}
    Set Selenium Implicit Wait    10s

Wait Until Element Is Visible and Enabled
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Wait Until Element Is Enabled    ${locator}    timeout=${timeout}

*** Test Cases ***

createAPI1.0bot

    [Documentation]    this creates an BR V2 API1.0 bot under Evolany Co., Ltd. company
    [Setup]    Setup Webdriver
    [Teardown]    Close Browser

    ${my_api10_bot_name}    Set Variable    test_bot_api10
    ${checkbox_values}=    Create List    crm    events    coupons    catalog    rms    chat    ec    mail    stores    campaign    elgana    g_events    bot_posts    user_logs    linepoints    sfa_salesforce    sfa_hubspot    lp    stamp_card    ms365    files
    ${h1_locator}=    Set Variable    //h1[@class='header-bot-name']

    Go To    ${environment}
    Wait Until Element Is Visible and Enabled    ${email_input}
    Input Text    ${email_input}    ${credentials}[email]
    Wait Until Element Is Visible and Enabled    ${pass_input}
    Input Text    ${pass_input}    ${credentials}[password]
    Wait Until Element Is Visible and Enabled    ${submit_button}
    Click Button    ${submit_button}
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
    Wait Until Element Is Visible and Enabled   ${company_name_options}
    Mouse Down    ${company_name_options}
    Click Element    ${company_name_option}
    #save new bot
    Wait Until Element Is Visible and Enabled   ${save_bot_settings}
    Click Button    ${save_bot_settings}
    #Verification
    Wait Until Element Is Visible   ${h1_locator}   timeout=60s
    Page Should Contain Element    ${h1_locator}
    Textfield Should Contain    ${h1_locator}    ${my_api10_bot_name}


createAPI2.0bot
    [Documentation]    this creates an BR V2 API1.0 bot under Evolany Co., Ltd. company
    [Setup]    Setup Webdriver
    [Teardown]    Close Browser

    ${my_api20_bot_name}    Set Variable    test_bot_api20
    ${checkbox_values}=    Create List    crm    events    coupons    catalog    rms    chat    ec    mail    stores    campaign    elgana    g_events    bot_posts    user_logs    linepoints    sfa_salesforce    sfa_hubspot    lp    stamp_card    ms365    files
    ${h1_locator}=    Set Variable    //h1[@class='header-bot-name']

    Go To    ${environment}
    Wait Until Element Is Visible and Enabled    ${email_input}
    Input Text    ${email_input}    ${credentials}[email]
    Wait Until Element Is Visible and Enabled    ${pass_input}
    Input Text    ${pass_input}    ${credentials}[password]
    Wait Until Element Is Visible and Enabled    ${submit_button}
    Click Button    ${submit_button}
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
    Select Radio Button   apiver   1
    #enter Company name
    Wait Until Element Is Visible and Enabled   ${company_name_input_field}
    Click Element    ${company_name_input_field}
    Wait Until Element Is Visible and Enabled   ${company_name_options}
    Mouse Down    ${company_name_options}
    Click Element    ${company_name_option}
    #save new bot
    Wait Until Element Is Visible and Enabled   ${save_bot_settings}
    Click Button    ${save_bot_settings}
    #Verification
    Wait Until Element Is Visible   ${h1_locator}   timeout=60s
    Page Should Contain Element    ${h1_locator}
    Textfield Should Contain    ${h1_locator}    ${my_api20_bot_name}



