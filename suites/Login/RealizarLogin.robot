*** Settings ***
Resource  ../../resources/main.resource

*** Test Cases ***
TC1: Login efetuado com sucesso
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    email=${EMAIL_TESTE}  status_code_desejado=201  
    Efetuar login  email=${EMAIL_TESTE}    status_code_desejado_Login=200  
    Conferir login
TC2: Login com erro de email
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest    email=${EMAIL_TESTE}  status_code_desejado=201  
    Efetuar login  email=teste@teste.com    status_code_desejado_Login=401  

