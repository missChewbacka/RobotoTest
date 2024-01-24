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

    ${my_api10_bot_name}    Set Variable    test_bot
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
    Wait Until Element Is Visible   ${h1_locator}   timeout=20s
    Page Should Contain Element    ${h1_locator}
    Textfield Should Contain    ${h1_locator}    ${my_api10_bot_name}


createAPI2.0bot

    [Documentation]    This test case creates an BR V2 API2.0 bot under Evolany Co., Ltd. company
    [Teardown]    Close Browser

    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --disable-notifications
    Call Method  ${options}  add_argument  --disable-infobars
    Call Method  ${options}  add_argument  --disable-extensions
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --start-maximized
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Create Webdriver    Chrome   options=${options}
    Go To    https://pre.bonp.me//member
    Wait Until Element Is Visible   //input[@name='email']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='email']   timeout=10s
    Input Text   //input[@name='email']   alexandra@evolany.com
    Wait Until Element Is Visible   //input[@name='pass']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='pass']   timeout=10s
    Input Text    //input[@name='pass']   221373897221373897qW!
    Wait Until Element Is Visible   //button[@type='text']
    Wait Until Element Is Enabled   //button[@type='text']
    Click Button   //button[@type='text']
    Wait Until Element Is Visible   //button[text()[contains(.,'New App')]]   timeout=10s
    Wait Until Element Is Enabled   //button[text()[contains(.,'New App')]]   timeout=10s
    Click Button   //button[text()[contains(.,'New App')]]
    #input bot name
    Wait Until Element Is Visible   //input[@name='name']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='name']   timeout=10s
    Input Text   //input[@name='name']    test_robotframework_bot_api2.0
    #check all bot moduls
    Select Checkbox    //input[@value='crm']
    Select Checkbox    //input[@value='events']
    Select Checkbox    //input[@value='coupons']
    Select Checkbox    //input[@value='catalog']
    Select Checkbox    //input[@value='rms']
    Select Checkbox    //input[@value='chat']
    Select Checkbox    //input[@value='ec']
    Select Checkbox    //input[@value='mail']
    Select Checkbox    //input[@value='stores']
    Select Checkbox    //input[@value='campaign']
    Select Checkbox    //input[@value='elgana']
    Select Checkbox    //input[@value='g_events']
    Select Checkbox    //input[@value='bot_posts']
    Select Checkbox    //input[@value='user_logs']
    Select Checkbox    //input[@value='linepoints']
    Select Checkbox    //input[@value='sfa_salesforce']
    Select Checkbox    //input[@value='sfa_hubspot']
    Select Checkbox    //input[@value='lp']
    Select Checkbox    //input[@value='stamp_card']
    Select Checkbox    //input[@value='ms365']
    Select Checkbox    //input[@value='files']
    #select plan option
    Select Radio Button   plan   pro
    #select API1.0 option
    Select Radio Button   apiver   2
    #enter Company name
    Click Element    //input[@target_name='com_id']
    Wait Until Element Is Visible   //ul[@id='form-item-autocomplete']/li   timeout=10s
    Wait Until Element Is Enabled   //ul[@id='form-item-autocomplete']/li   timeout=10s
    Mouse Down    //ul[@id='form-item-autocomplete']/li
    Click Element    (//ul[@id='form-item-autocomplete']/li)[1]
    #save new bot
    Wait Until Element Is Visible   //button[@class='icon save']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='icon save']   timeout=10s
    Click Button    //button[@class='icon save']

add Events API2.0 bot

    [Documentation]    This test case adds 3 events for BR V2 API2.0 bot under Evolany Co., Ltd. company.
    [Teardown]    Close Browser

    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --disable-notifications
    Call Method  ${options}  add_argument  --disable-infobars
    Call Method  ${options}  add_argument  --disable-extensions
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --start-maximized
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Create Webdriver    Chrome   options=${options}
    Go To    https://pre.bonp.me//member
    Wait Until Element Is Visible   //input[@name='email']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='email']   timeout=10s
    Input Text   //input[@name='email']   alexandra@evolany.com
    Wait Until Element Is Visible   //input[@name='pass']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='pass']   timeout=10s
    Input Text    //input[@name='pass']   221373897221373897qW!
    Wait Until Element Is Visible   //button[@type='text']
    Wait Until Element Is Enabled   //button[@type='text']
    Click Button   //button[@type='text']
    Wait Until Element Is Visible   (//table[@class='list-view']/tr/td[@i='0'])   timeout=10s
    Wait Until Element Is Enabled   (//table[@class='list-view']/tr/td[@i='0'])   timeout=10s
    Click Element    (//table[@class='list-view']/tr/td[@i='0'])
    Wait Until Element Is Visible   //h1[contains(.,'test_robotframework_bot_api2.0')]   timeout=10s
    Click Element    //a[@class='miniapps icon dots-v']
    Wait Until Element Is Visible   //section[@class='submenus']/ul/li   timeout=10s
    Wait Until Element Is Enabled   //section[@class='submenus']/ul/li   timeout=10s
    Click Element    (//section[@class='submenus']/ul/li)[2]
    Wait Until Element Is Visible   //button[@class='new icon plus-square']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='new icon plus-square']   timeout=10s
    Click Button    //button[@class='new icon plus-square']
    Input Text    //input[@name='linkto']   https://www.udemy.com/
    Choose File    (//input[@type='file'])[1]   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img1.jpg
    Input Text    //input[@name='title']   Test Event1
    Input Text    //textarea[@name='desc']   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae arcu turpis. Morbi quis dignissim nunc, nec luctus nibh. In luctus porttitor posuere. Quisque.
    Input Text    //input[@name='seats']   1
    Sleep    2s
    Wait Until Element Is Visible   //button[@class='icon save']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='icon save']   timeout=10s
    Click Button    //button[@class='icon save']
    Sleep    6s
    Click Element    //footer/button
    #event2
    Wait Until Element Is Visible   //button[@class='new icon plus-square']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='new icon plus-square']   timeout=10s
    Click Button    //button[@class='new icon plus-square']
    Input Text    //input[@name='linkto']   https://www.udemy.com/
    Choose File    (//input[@type='file'])[1]   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img2.jpg
    Input Text    //input[@name='title']   Test Event2
    Input Text    //textarea[@name='desc']   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae arcu turpis. Morbi quis dignissim nunc, nec luctus nibh. In luctus porttitor posuere. Quisque.
    Input Text    //input[@name='seats']   1
    Sleep    2s
    Wait Until Element Is Visible   //button[@class='icon save']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='icon save']   timeout=10s
    Click Button    //button[@class='icon save']
    Sleep    6s
    Click Element    //footer/button
    #event3
    Wait Until Element Is Visible   //button[@class='new icon plus-square']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='new icon plus-square']   timeout=10s
    Click Button    //button[@class='new icon plus-square']
    Input Text    //input[@name='linkto']   https://www.udemy.com/
    Choose File    (//input[@type='file'])[1]   C://Users//Professional//PycharmProjects//suffering-upd//uploaddata//event_img3.jpg
    Input Text    //input[@name='title']   Test Event2
    Input Text    //textarea[@name='desc']   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vitae arcu turpis. Morbi quis dignissim nunc, nec luctus nibh. In luctus porttitor posuere. Quisque.
    Input Text    //input[@name='seats']   1
    Sleep    2s
    Wait Until Element Is Visible   //button[@class='icon save']   timeout=10s
    Wait Until Element Is Enabled   //button[@class='icon save']   timeout=10s
    Click Button    //button[@class='icon save']
    Sleep    6s
    Click Element    //footer/button

group1API2.0bot

    [Documentation]    This test case adds group1 BR V2 API2.0 bot under Evolany Co., Ltd. company.
    [Teardown]    Close Browser

    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --disable-notifications
    Call Method  ${options}  add_argument  --disable-infobars
    Call Method  ${options}  add_argument  --disable-extensions
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --start-maximized
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Create Webdriver    Chrome   options=${options}
    Go To    https://pre.bonp.me//member
    Wait Until Element Is Visible   //input[@name='email']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='email']   timeout=10s
    Input Text   //input[@name='email']   alexandra@evolany.com
    Wait Until Element Is Visible   //input[@name='pass']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='pass']   timeout=10s
    Input Text    //input[@name='pass']   221373897221373897qW!
    Wait Until Element Is Visible   //button[@type='text']
    Wait Until Element Is Enabled   //button[@type='text']
    Click Button   //button[@type='text']
    Wait Until Element Is Visible   (//table[@class='list-view']/tr/td[@i='0'])   timeout=10s
    Wait Until Element Is Enabled   (//table[@class='list-view']/tr/td[@i='0'])   timeout=10s
    Click Element    (//table[@class='list-view']/tr/td[@i='0'])
    Wait Until Element Is Visible   //h1[contains(.,'test_robotframework_bot_api2.0')]   timeout=10s
    Sleep    3s
    Click Element    //dd[@msg='navi-flow']
    Wait Until Element Is Visible    (//button[@class='icon plus-square'])[1]   timeout=10s
    Wait Until Element Is Enabled   (//button[@class='icon plus-square'])[1]   timeout=10s
    Sleep    2s
    Mouse Over    (//button[@class='icon plus-square'])[1]
    Wait Until Element Is Visible    //dd[@class='new-group']   timeout=10s
    Wait Until Element Is Enabled   //dd[@class='new-group']   timeout=10s
    Click Element    //dd[@class='new-group']
    Wait Until Element Is Visible    //li[@class='group_0 editing on']//input[@type='text']   timeout=10s
    Wait Until Element Is Enabled   //li[@class='group_0 editing on']//input[@type='text']   timeout=10s
    Input Text    //li[@class='group_0 editing on']//input[@type='text']    group1
    Press Keys   //li[@class='group_0 editing on']//input[@type='text']    ENTER
    Wait Until Element Is Visible    //h5[normalize-space()='group1']   timeout=10s
    Wait Until Element Is Enabled   //h5[normalize-space()='group1']   timeout=10s
    Click Element    //h5[normalize-space()='group1']
    #textitem1
    Mouse Over    (//button[@class='icon plus-square'])[2]
    Click Element    //dd[@rt='text']
    Press Keys    //dd[@rt='text']   ENTER
    Wait Until Element Is Visible    //div[@class='title-line']/input[@type='text']   timeout=10s
    Wait Until Element Is Enabled   //div[@class='title-line']/input[@type='text']   timeout=10s
    Click Element    //div[@class='title-line']/input[@type='text']
    Clear Element Text    //div[@class='title-line']/input[@type='text']
    Input Text    //div[@class='title-line']/input[@type='text']    textitem1
    Press Keys    //div[@class='title-line']/input[@type='text']   ENTER
    Click Element    (//textarea[@class='msg with-emoticon'])[1]
    Input Text    (//textarea[@class='msg with-emoticon'])[1]    textitem1
    Press Keys    (//textarea[@class='msg with-emoticon'])[1]   ENTER
    #textitem2
    Mouse Over    (//button[@class='icon plus-square'])[2]
    Click Element    //dd[@rt='text']
    Press Keys    //dd[@rt='text']   ENTER
    Wait Until Element Is Visible    (//div[@class='title-line']/input[@type='text'])[2]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='title-line']/input[@type='text'])[2]   timeout=10s
    Click Element    (//div[@class='title-line']/input[@type='text'])[2]
    Clear Element Text    (//div[@class='title-line']/input[@type='text'])[2]
    Input Text    (//div[@class='title-line']/input[@type='text'])[2]    textitem2
    Press Keys    (//div[@class='title-line']/input[@type='text'])[2]   ENTER
    Click Element    (//textarea[@class='msg with-emoticon'])[2]
    Input Text    (//textarea[@class='msg with-emoticon'])[2]    textitem2
    Press Keys    (//textarea[@class='msg with-emoticon'])[2]   ENTER
    #textitem3
    Mouse Over    (//button[@class='icon plus-square'])[2]
    Click Element    //dd[@rt='text']
    Press Keys    //dd[@rt='text']   ENTER
    Wait Until Element Is Visible    (//div[@class='title-line']/input[@type='text'])[3]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='title-line']/input[@type='text'])[3]   timeout=10s
    Click Element    (//div[@class='title-line']/input[@type='text'])[3]
    Clear Element Text    (//div[@class='title-line']/input[@type='text'])[3]
    Input Text    (//div[@class='title-line']/input[@type='text'])[3]    textitem3
    Press Keys    (//div[@class='title-line']/input[@type='text'])[3]   ENTER
    Click Element    (//textarea[@class='msg with-emoticon'])[3]
    Input Text    (//textarea[@class='msg with-emoticon'])[3]    textitem3
    Press Keys    (//textarea[@class='msg with-emoticon'])[3]   ENTER
    #textitem4
    Mouse Over    (//button[@class='icon plus-square'])[2]
    Click Element    //dd[@rt='text']
    Press Keys    //dd[@rt='text']   ENTER
    Wait Until Element Is Visible    (//div[@class='title-line']/input[@type='text'])[4]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='title-line']/input[@type='text'])[4]   timeout=10s
    Click Element    (//div[@class='title-line']/input[@type='text'])[4]
    Clear Element Text    (//div[@class='title-line']/input[@type='text'])[4]
    Input Text    (//div[@class='title-line']/input[@type='text'])[4]    textitem4
    Press Keys    (//div[@class='title-line']/input[@type='text'])[4]   ENTER
    Click Element    (//textarea[@class='msg with-emoticon'])[4]
    Input Text    (//textarea[@class='msg with-emoticon'])[4]    textitem4
    Press Keys    (//textarea[@class='msg with-emoticon'])[4]   ENTER
    #big button textitem1
    Click Element    (//section[@class='actions']/ul/li)[1]
    Wait Until Element Is Visible    (//li[@tp='items'])[1]   timeout=10s
    Wait Until Element Is Enabled   (//li[@tp='items'])[1]   timeout=10s
    Click Element    (//li[@tp='items'])[1]
    Wait Until Element Is Visible    //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Wait Until Element Is Enabled   //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Clear Element Text    //div[@class='form-type-text']/input[@name='label']
    Input Text    //div[@class='form-type-text']/input[@name='label']    text1 button
    Click Button    //button[@class='icon save label']
    #quick reaction buttons textitem2
    Click Element    (//section[@class='actions']/ul/li)[2]
    Wait Until Element Is Visible    (//div[@class='react-btns empty']/label)[2]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='react-btns empty']/label)[2]   timeout=10s
    Click Element    (//div[@class='react-btns empty']/label)[2]
    Wait Until Element Is Visible    //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Wait Until Element Is Enabled   //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Input Text    //div[@class='form-type-text']/input[@name='label']    choice1
    Sleep    3s
    Click Element    //label[@data-value='manual']/input
    Sleep    2s
    Click Element    //input[@target_name='act']
    Sleep    2s
    Input Text    //input[@target_name='act']    3:textitem3
    Press Keys    //input[@target_name='act']    ENTER
    Sleep    2s
    Click Element    //label[@class='icon cog advanced-button']
    Sleep    2s
    Input Text    //input[@name='ukey']    choice
    Press Keys    //input[@name='ukey']    ENTER
    Sleep    2s
    Click Button    //button[@class='icon save label']
    Sleep    2s
    Click Element    (//section[@class='actions']/ul/li)[2]
    Wait Until Element Is Visible    (//div[@class='react-btns empty']/label)[3]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='react-btns empty']/label)[3]   timeout=10s
    Click Element    (//div[@class='react-btns empty']/label)[3]
    Wait Until Element Is Visible    //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Wait Until Element Is Enabled   //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Input Text    //div[@class='form-type-text']/input[@name='label']    choice2
    Sleep    3s
    Click Element    //label[@data-value='manual']/input
    Sleep    2s
    Click Element    //input[@target_name='act']
    Sleep    2s
    Input Text    //input[@target_name='act']    3:textitem3
    Press Keys    //input[@target_name='act']    ENTER
    Sleep    2s
    Click Element    //label[@class='icon cog advanced-button']
    Sleep    2s
    Input Text    //input[@name='ukey']    choice
    Press Keys    //input[@name='ukey']    ENTER
    Sleep    2s
    Click Button    //button[@class='icon save label']
    Sleep    2s


add quick reaction buttons

    [Documentation]    This test case adds quick reaction buttons BR V2 API2.0 bot under Evolany Co., Ltd. company.
    [Teardown]    Close Browser

    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --disable-notifications
    Call Method  ${options}  add_argument  --disable-infobars
    Call Method  ${options}  add_argument  --disable-extensions
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --start-maximized
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Create Webdriver    Chrome   options=${options}
    Go To    https://pre.bonp.me//member
    Wait Until Element Is Visible   //input[@name='email']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='email']   timeout=10s
    Input Text   //input[@name='email']   alexandra@evolany.com
    Wait Until Element Is Visible   //input[@name='pass']   timeout=10s
    Wait Until Element Is Enabled   //input[@name='pass']   timeout=10s
    Input Text    //input[@name='pass']   221373897221373897qW!
    Wait Until Element Is Visible   //button[@type='text']
    Wait Until Element Is Enabled   //button[@type='text']
    Click Button   //button[@type='text']
    Wait Until Element Is Visible   (//table[@class='list-view']/tr/td[@i='3'])[2]   timeout=10s
    Wait Until Element Is Enabled   (//table[@class='list-view']/tr/td[@i='3'])[2]   timeout=10s
    Click Element    (//table[@class='list-view']/tr/td[@i='3'])[2]
    Wait Until Element Is Visible   //h1[contains(.,'test_robotframework_bot_api2.0')]   timeout=10s
    Sleep    3s
    Click Element    //dd[@msg='navi-flow']
    Wait Until Element Is Visible   //h5[normalize-space()='group1']   timeout=10s
    Wait Until Element Is Enabled   //h5[normalize-space()='group1']   timeout=10s
    Click Element    //h5[normalize-space()='group1']
    Click Element    (//section[@class='actions']/ul/li)[2]
    Wait Until Element Is Visible    (//div[@class='react-btns empty']/label)[2]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='react-btns empty']/label)[2]   timeout=10s
    Click Element    (//div[@class='react-btns empty']/label)[2]
    Wait Until Element Is Visible    //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Wait Until Element Is Enabled   //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Input Text    //div[@class='form-type-text']/input[@name='label']    choice1
    Sleep    3s
    Click Element    //label[@data-value='manual']/input
    Sleep    2s
    Click Element    //input[@target_name='act']
    Sleep    2s
    Input Text    //input[@target_name='act']    3:textitem3
    Press Keys    //input[@target_name='act']    ENTER
    Sleep    2s
    Click Element    //label[@class='icon cog advanced-button']
    Sleep    2s
    Input Text    //input[@name='ukey']    choice
    Press Keys    //input[@name='ukey']    ENTER
    Sleep    2s
    Click Button    //button[@class='icon save label']
    Sleep    2s
    Click Element    (//section[@class='actions']/ul/li)[2]
    Wait Until Element Is Visible    (//div[@class='react-btns empty']/label)[3]   timeout=10s
    Wait Until Element Is Enabled   (//div[@class='react-btns empty']/label)[3]   timeout=10s
    Click Element    (//div[@class='react-btns empty']/label)[3]
    Wait Until Element Is Visible    //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Wait Until Element Is Enabled   //div[@class='form-type-text']/input[@name='label']   timeout=10s
    Input Text    //div[@class='form-type-text']/input[@name='label']    choice2
    Sleep    3s
    Click Element    //label[@data-value='manual']/input
    Sleep    2s
    Click Element    //input[@target_name='act']
    Sleep    2s
    Input Text    //input[@target_name='act']    3:textitem3
    Press Keys    //input[@target_name='act']    ENTER
    Sleep    2s
    Click Element    //label[@class='icon cog advanced-button']
    Sleep    2s
    Input Text    //input[@name='ukey']    choice
    Press Keys    //input[@name='ukey']    ENTER
    Sleep    2s
    Click Button    //button[@class='icon save label']
    Sleep    2s



