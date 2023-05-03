*** Settings ***
Resource  ../../resources/main.resource

*** Test Cases ***
TC1: Deletar um novo usuário com sucesso na ServeRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  email=${EMAIL_TESTE}  status_code_desejado=201
    Conferir se o usuário foi cadastrado corretamente
    Deletar o usuario cadastrado
    Conferir se o usuário foi deletado