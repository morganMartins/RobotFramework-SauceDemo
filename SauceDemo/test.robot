*** Settings ***
Library             SeleniumLibrary

# install faker : pip install robotframework-faker
# Library    FakerLibrary
Test Setup          Open Browser    https://saucedemo.com    Chrome
Test Teardown       Close Browser


*** Variables ***
${url}              https://saucedemo.com
${browser}          Chrome
${PASSWORD}         secret_sauce
${success-login}    standard_user
${locked-user}      locked_out_user


*** Test Cases ***
Authentification avec succès
    Input Text    id:user-name    ${success-login}
    Input Text    id:password    ${PASSWORD}
    Click Button    login-button
    Page Should Contain    Products

Authentification en utilisant un nom dutilisateur vide et un mot de passe
    Input Text    id:password    ${PASSWORD}
    Click Button    login-button
    Page Should Contain    Epic sadface: Username is required

Authentification avec un nom dutilisateur et un mot de passe vide
    Input Text    id:user-name    ${success-login}
    Click Button    login-button
    Page Should Contain    Epic sadface: Password is required

Authentification avec un utilisateur bloqué locked_out_user
    Input Text    id:user-name    ${locked-user}
    Input Text    id:password    ${PASSWORD}
    Click Button    login-button

Test de bout en bout avec achat de produit
    Input Text    id:user-name    ${success-login}
    Input Text    id:password    ${PASSWORD}
    Click Button    login-button
    Page Should Contain    Products
    Click Element    id:add-to-cart-sauce-labs-backpack
    Click Element    class:shopping_cart_link
    Page Should Contain    Your Cart
    Sleep    1
    Click Element    id:checkout
    Input Text    id:first-name    Jonnhy
    Input Text    id:last-name    Bravo
    Input Text    id:postal-code    33000
    Click Button    id:continue
    Page Should Contain    Checkout: Overview
    Click Button    id:finish
    Page Should Contain    Checkout: Complete
    Click Button    id:back-to-products
