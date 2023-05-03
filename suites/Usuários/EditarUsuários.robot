*** Settings ***
Resource  ../../resources/main.resource

*** Test Cases ***
TC01: Alterar os dados de um novo usuário
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  email=${EMAIL_TESTE}  status_code_desejado=201
    Consultar os dados do novo usuário
    Alterar o usuário criado    julia  