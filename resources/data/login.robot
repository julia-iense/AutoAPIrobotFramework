*** Settings ***
Resource  ../main.resource

*** Keywords ***
Efetuar login
    [Arguments]  ${email}  ${status_code_desejado_Login} 
    &{bodyLogin}  Create Dictionary
    ...      email=${email}
    ...      password=1234
    Log    ${bodyLogin}

    Criar Sessão na ServeRest

    ${respostaLogin}  POST On Session
    ...               alias=ServeRest
    ...               url=Login
    ...               json=${bodyLogin}
    ...               expected_status=${status_code_desejado_Login}
    Log    ${respostaLogin}

    IF  ${status_code_desejado_Login} == 200
        Set Suite Variable   ${respostaLogin}  ${respostaLogin.json()}
    END
        Log    ${respostaLogin}
  ${token}=  Set Variable    ${respostaLogin.json()} ["authorization"]
Conferir login
    Log  ${respostaLogin}
    Dictionary Should Contain Item    ${respostaLogin}  message          Login realizado com sucesso
    Log  ${respostaLogin}
    Dictionary Should Contain Key     ${respostaLogin}  authorization    
    Log  ${respostaLogin}
