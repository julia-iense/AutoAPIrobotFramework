*** Settings ***
Resource  ../main.resource


*** Keywords ***
Criei uma sessão na API com token
    ${headers}  Create Dictionary  
    ...  accept=*/*  
    ...  content-type=application/json  
    ...  Authorization=${token}  
    Create Session  
    ...  alias=ServeRest
    ...  url=${URL} 
    ...  headers=${headers}
Cadastrar produtos
    ${nome_aleatoria}  Generate Random String  length=8  chars=[LETTERS]
    ${nome_aleatoria}  Convert To Lower Case   ${nome_aleatoria}

    [Arguments]   ${status_code_produto}  
     &{bodyProduto}  Create Dictionary
    ...      nome=${nome_aleatoria}
    ...      preco=470
    ...      descricao=mouse
    ...      quantidade=381 
    Log    ${bodyProduto}

    ${respostaProduto}  POST On Session
    ...          alias=ServeRest
    ...          url=produtos
    ...          json=${bodyProduto}
    ...          expected_status=201 
    Log       ${respostaProduto}

Conferir Cadastro de produto
    Dictionary Should Contain Item    ${resposta}    message    Cadastro realizado com sucesso
