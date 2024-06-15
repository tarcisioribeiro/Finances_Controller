from data.cache.session_state import logged_user, logged_user_password
from dictionary.sql import user_current_accounts_query
from io import BytesIO
from dictionary.vars import to_remove_list
from functions.query_executor import QueryExecutor
from functions.tests.var_tests import VarTests
from time import sleep
import datetime
import pandas as pd
import streamlit as st


class AccountStatement:

    def __init__(self):

        query_executor = QueryExecutor()
        var_tests = VarTests()

        def mount_statement_query(statement_type: str, accounts: list, initial_data: str, final_data: str):

            statement_query_list = []

            str_accounts = '''('''

            for i in range(0, len(accounts)):
                if i < (len(accounts) - 1):
                    str_accounts += "'" + str(accounts[i]) + "'" + ''', '''
                elif i == len(accounts) - 1:
                    str_accounts += "'" + str(accounts[i]) + "'"

            str_accounts = str_accounts + ''')'''

            expenses_statement_query = '''
                SELECT 
                    despesas.descricao,
                    despesas.valor,
                    despesas.data,
                    despesas.horario,
                    despesas.categoria,
                    despesas.conta
                FROM
                    despesas
                        INNER JOIN
                    contas ON despesas.conta = contas.nome_conta
                        AND despesas.proprietario_despesa = contas.proprietario_conta
                        INNER JOIN
                    usuarios ON despesas.proprietario_despesa = usuarios.nome
                        AND despesas.documento_proprietario_despesa = usuarios.cpf
                WHERE
                    despesas.pago = 'S'
                        AND despesas.data >= '{}'
                        AND despesas.data <= '{}'
                        AND despesas.conta IN {}
                        AND usuarios.login = '{}'
                        AND usuarios.senha = '{}';
            '''.format(initial_data, final_data, str_accounts, logged_user, logged_user_password)

            revenues_statement_query = '''
                SELECT 
                    receitas.descricao,
                    receitas.valor,
                    receitas.data,
                    receitas.horario,
                    receitas.categoria,
                    receitas.conta
                FROM
                    receitas
                        INNER JOIN
                    contas ON receitas.conta = contas.nome_conta
                        AND receitas.proprietario_receita = contas.proprietario_conta
                        INNER JOIN
                    usuarios ON receitas.proprietario_receita = usuarios.nome
                        AND receitas.documento_proprietario_receita = usuarios.cpf
                WHERE
                    receitas.recebido = 'S'
                        AND receitas.data >= '{}'
                        AND receitas.data <= '{}'
                        AND receitas.conta IN {}
                        AND usuarios.login = '{}'
                        AND usuarios.senha = '{}';
            '''.format(initial_data, final_data, str_accounts, logged_user, logged_user_password)

            if statement_type == 'Despesas':
                statement_query_list.append(expenses_statement_query)
            elif statement_type == 'Receitas':
                statement_query_list.append(revenues_statement_query)
            elif statement_type == 'Despesas e Receitas':
                statement_query_list.append(expenses_statement_query)
                statement_query_list.append(revenues_statement_query)
            
            return statement_query_list

        def consult_statement(statement_query_list: list):

            empty_list: list

            for i in range(len(statement_query_list)):
                empty_list = query_executor.complex_compund_query(statement_query_list[i], 6, 'statement_')

                description, value, date, time, category, account = (empty_list)

                if len(description) == 0 and len(value) == 0 and len(date) == 0 and len(time) == 0 and len(category) == 0 and len(account) == 0:
                    with st.expander(label="Relatório", expanded=True):
                        st.info(body="Nao há registros neste período.")

                elif len(description) > 0 and len(value) > 0 and len(date) > 0 and len(time) > 0 and len(category) > 0 and len(account) > 0: 

                    aux_str = ''''''

                    for i in range(0, len(time)):
                        aux_str = str(time[i])
                        time[i] = aux_str

                    with st.expander(label="Relatório", expanded=True):

                        loan_data_df = pd.DataFrame(
                            {
                                "Descrição": description,
                                "Valor": value,
                                "Data": date,
                                "Horário": time,
                                "Categoria": category,
                                "Conta": account,
                            }
                        )

                        loan_data_df["Valor"] = loan_data_df["Valor"].apply(lambda x: f"R$ {x:.2f}")
                        loan_data_df["Data"] = pd.to_datetime(loan_data_df["Data"]).dt.strftime("%d/%m/%Y")
                        st.dataframe(loan_data_df, hide_index=True, use_container_width=True)

        def main_menu():

            user_current_accounts = query_executor.complex_consult_query(user_current_accounts_query)
            user_current_accounts = query_executor.treat_numerous_simple_result(user_current_accounts, to_remove_list)

            col4, col5, col6 = st.columns(3)

            with col4:

                with st.expander(label="Dados", expanded=True):

                    statement_option = st.selectbox(label="Tipos de extrato", options=["Selecione uma opção", "Despesas", "Receitas", "Despesas e Receitas"])
                    selected_accounts = st.multiselect(label="Contas", options=user_current_accounts, placeholder="Escolha a(s) conta(s)")
                    initial_data = st.date_input(label="Data de início")
                    final_data = st.date_input(label="Data de fim")
                    confirm_choice = st.checkbox(label="Confirmar dados")

                consult_tables = st.button(label="Gerar Relatórios")

            if confirm_choice and consult_tables:

                with col5:
                
                    if statement_option != "Selecione uma opção" and len(selected_accounts) > 0 and (initial_data <= final_data):
                            query_list = []
                            query_list = mount_statement_query(statement_option, selected_accounts, initial_data, final_data)

                            with st.spinner(text="Aguarde..."):
                                sleep(2)

                            consult_statement(query_list)

                            with col6:

                                with st.spinner(text="Aguarde..."):
                                    sleep(2)

                    elif confirm_choice and len(selected_accounts) == 0 and initial_data > final_data:
                            st.error(body="Nenhuma conta selecionada.")
                            st.error(body="A data inicial não pode ser maior que a final.")
                
                    elif confirm_choice and initial_data > final_data:
                            st.error(body="A data inicial não pode ser maior que a final.")

        self.main_menu = main_menu
