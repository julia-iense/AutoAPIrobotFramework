*** Settings ***
Resource  ../../resources/main.resource

*** Test Cases ***
Cadastrar produtos
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    email=${EMAIL_TESTE}  status_code_desejado=201  
    Efetuar login    email=${EMAIL_TESTE}    status_code_desejado_Login=200 
    Criei uma sessão na API com token  
    Cadastrar produtos    201
    Conferir Cadastro de produto