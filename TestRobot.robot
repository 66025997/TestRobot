*** Settings ***
Library    SeleniumLibrary
 
*** Variables ***
${URL}               http://automationexercise.com
${BROWSER}           Chrome
${ADD_TO_CART_BTN}   (//a[contains(text(),'Add to cart')])[1]
${CART_BTN}          //a[@href='/view_cart']
${REMOVE_BTN}        //a[@class='cart_quantity_delete']
 
*** Test Cases ***
Remove Product From Cart
    Open Browser    ${URL}    ${BROWSER}
 
    # ดูหน้าโฮม
    ${title}    Get Title
    Should Contain    ${title}    Automation Exercise
    Log    ✅ หน้าแรกโหลดสำเร็จ
 
    # เอา ads ออก
    Execute JavaScript    var ads = document.querySelectorAll('iframe'); ads.forEach(ad => ad.remove());
    Sleep    2s
 
    # เพิ่มสินค้า
    ${element}    Get WebElement    ${ADD_TO_CART_BTN}
    Execute JavaScript    arguments[0].dispatchEvent(new Event('click'));    ARGUMENTS    ${element}
    Sleep    2s
 
    # Handle popup
    Run Keyword And Ignore Error    Click Button    //button[text()='Continue Shopping']
    Log    ✅ เพิ่มสินค้าลงตะกร้าสำเร็จ
 
    # ไปที่ cart
    Click Element    ${CART_BTN}
    Sleep    2s
 
    # ตรวจสินค้า
    Page Should Contain    Shopping Cart
    Log    ✅ หน้าตะกร้าแสดงสำเร็จ
 
    # ลบสินค้า
    Click Element    ${REMOVE_BTN}
    Sleep    3s
 
    Close Browser