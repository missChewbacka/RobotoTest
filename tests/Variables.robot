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





