#include <stdio.h>
#include <windows.h>
#include <sql.h>
#include <sqlext.h>
#include<sqltypes.h>
#include <iostream>
#include <string.h>

using namespace std;

void sqlIUD(SQLHDBC *dbc, char *command)
{
    SQLHSTMT stmt;
    SQLRETURN ret;
    SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);
    ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);
}

void recoverPrint(SQLHDBC *dbc, char *command)
{
    SQLHSTMT stmt;
    SQLRETURN ret;
    SQLLEN indicator[4];
    SQLDOUBLE tamanho;
    SQLCHAR nomesatelite[50]="";
    SQLCHAR composicao[50]="";
    SQLCHAR nomeplaneta[50]="";
    int qnt=0;
    stmt=NULL;
    SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);
    ret = SQLBindCol(stmt,1,SQL_C_CHAR,nomesatelite,sizeof(nomesatelite),&indicator[0]);
    ret = SQLBindCol(stmt,2,SQL_C_DOUBLE,&tamanho,0,&indicator[1]);
    ret = SQLBindCol(stmt,3,SQL_C_CHAR,composicao,sizeof(composicao),&indicator[2]);
    ret = SQLBindCol(stmt,4,SQL_C_CHAR,nomeplaneta,sizeof(nomeplaneta),&indicator[3]);
    ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);
    while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
    {
        printf("nomesatelite: %s tamanhosatelite : %.2f composicao: %s nomeplaneta: %s\n", nomesatelite,tamanho,composicao,nomeplaneta);
        qnt++;
    }

    printf("Numero de linhas retornadas : %d\n", qnt);
}

int main()
{
    SQLHENV env;
    SQLHDBC dbc;
    SQLHSTMT stmt;
    SQLRETURN ret;
    char input[200];
    int status,ok=0;
    SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
    SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *) SQL_OV_ODBC3, 0);
    SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);
    SQLDriverConnect(dbc, NULL, (SQLCHAR*)"DSN=GDI;", SQL_NTS,NULL, 0, NULL, SQL_DRIVER_COMPLETE);

    while(true)
    {
        cout << "0 - encerrar\n1 - Insercao\n2 - Atualizacao\n3 - Remocao\n4 - Selecao\nDigite sua opcao:" << endl;
        cin >> status;
        fflush(stdin);
        switch(status)
        {
            case 0:
                cout << "Encerrando." << endl << "Encerrando.." << endl << "Encerrando..." << endl << "Finalizado!!!" << endl;
                ok = 1;
                break;
            case 1:
                 printf("Digite o comando de insercao:\n");
                 gets(input);
                 sqlIUD(&dbc, input);
                break;
            case 2:
                printf("Digite o comando de atualizacao:\n");
                gets(input);
                sqlIUD(&dbc, input);
                break;
            case 3:
                 printf("Digite o comando de remocao:\n");
                gets(input);
                sqlIUD(&dbc, input);
                break;
            case 4:
                char where[50];
                printf("Digite o Where do Select para tabela satelite:\n");
                strcpy(input,"Select * From satelite ");
                gets(where);
                strcat(input,where);
                cout << input << endl;
                recoverPrint(&dbc, input);
                break;
            default:
                cout << "Comando invalido!!!" << endl;
                break;
        }

        if(ok)
            break;
    }
    return 0;
}


