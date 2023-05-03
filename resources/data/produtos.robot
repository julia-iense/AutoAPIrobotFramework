*** Settings ***
Resource  ../main.resource

*** Keywords ***
Cadastrar produtos
    [Arguments]   ${status_code_produto}  
     &{bodyProduto}  Create Dictionary
    ...      nome=Logitech MX Vertical
    ...      preco=470
    ...      descricao=mouse
    ...      quantidade=381 
    Log    ${bodyProduto}

    Criar Sessão na ServeRest

    ${respostaProduto}  POST On Session
    ...          alias=ServeRest
    ...          url=Produtos
    ...          json=${bodyProduto}
    ...          expected_status=200 
    Log       ${respostaProduto}

Conferir Cadastro de produto
    Dictionary Should Contain Item    ${resposta}    message    Cadastro realizado com sucesso
