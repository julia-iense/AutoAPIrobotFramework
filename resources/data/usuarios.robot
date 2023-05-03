*** Settings ***
Resource  ../main.resource

*** Keywords ***
Criar Sessão na ServeRest
    ${headers}  Create Dictionary  accept=application/json  Content-Type=application/json
    Create Session    alias=ServeRest    url=${url}   headers=${headers}

Criar um usuário novo
    ${palavra_aleatoria}  Generate Random String  length=4  chars=[LETTERS]
    ${palavra_aleatoria}  Convert To Lower Case   ${palavra_aleatoria}
    Set Test Variable     ${EMAIL_TESTE}  ${palavra_aleatoria}@teste.com
    Log  ${EMAIL_TESTE}

Cadastrar o usuário criado na ServeRest
    [Arguments]  ${email}  ${status_code_desejado}
    ${body}  Create Dictionary
    ...      nome=teste teste
    ...      email=${email}
    ...      password=1234
    ...      administrador=true   
    Log   ${body}
    
    Criar Sessão na ServeRest

    ${resposta}  POST On Session
    ...          alias=ServeRest
    ...          url=/usuarios
    ...          json=${body}
    ...          expected_status=${status_code_desejado}

    Log  ${resposta.json()}
    
    IF  ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}  ${resposta.json()["_id"]}
    END

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
Conferir se o usuário foi cadastrado corretamente
    Log  ${RESPOSTA}
    Dictionary Should Contain Item  ${RESPOSTA}  message  Cadastro realizado com sucesso
    Dictionary Should Contain Key   ${RESPOSTA}  _id

Vou repetir o cadastro do usuário
    Cadastrar o usuário criado na ServeRest  email=${EMAIL_TESTE}  status_code_desejado=400

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}  GET On Session  alias=ServeRest  url=/usuarios/${ID_USUARIO}  expected_status=200
   
    # Obtendo as propriedades do objeto response
    Log   ${resposta_consulta.status_code}
    Log   ${resposta_consulta.reason}
    Log   ${resposta_consulta.headers}
    Log   ${resposta_consulta.elapsed}
    Log   ${resposta_consulta.text}
    Log   ${resposta_consulta.json()}
    
    Set Test Variable     ${RESP_CONSULTA}  ${resposta_consulta.json()}
Conferir os dados retornados
    Log   ${RESP_CONSULTA}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome            teste teste
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email           ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password        1234
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador   true
    Dictionary Should Contain Item    ${RESP_CONSULTA}    _id             ${ID_USUARIO}

Deletar o usuario cadastrado
    ${resposta_consulta_delete}  DELETE On Session  alias=ServeRest  url=/usuarios/${ID_USUARIO}  expected_status=200
    Set Test Variable    ${REST_DELETE}   ${resposta_consulta_delete.json()}

Conferir se o usuário foi deletado
    Log   ${REST_DELETE}
    Dictionary Should Contain Item     ${REST_DELETE}  message    Registro excluído com sucesso

Alterar o usuário criado
    [Arguments]  ${email}  
    ${body2}=   Create Dictionary
    ...    Nome=maria
    ...    password=4569
    ...    administrador=true  
    Log    ${body2} 
        
        PUT On Session   
    ...   alias=ServeRest  
    ...  url=/usuarios/${ID_USUARIO}  
    ...  json=${body2}
    ...  expected_status=400

