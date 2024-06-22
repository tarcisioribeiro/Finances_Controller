import streamlit as st
from dictionary.vars import to_remove_list, absolute_app_path
from dictionary.sql import doc_name_query, name_query, sex_query
from functions.query_executor import QueryExecutor
from time import sleep


class User:
    def __init__(self):

        query_executor = QueryExecutor()

        def validate_login(login: str, password: str):

            check_if_user_exists = query_executor.check_if_value_exists("SELECT login FROM usuarios WHERE login = '{}'".format(login))

            if check_if_user_exists:
                password_query = "SELECT senha FROM usuarios WHERE login = '{}'".format(login)
                password = query_executor.simple_consult_query(password_query)

                if password:
                    return password
                else:
                    return False
            else:
                return False

        def get_user_doc_name():

            user_doc_name = query_executor.complex_consult_query(doc_name_query)
            treated_user_doc_name = query_executor.treat_complex_result(user_doc_name, to_remove_list)

            owner_name = treated_user_doc_name[0]
            owner_document = treated_user_doc_name[1]

            return owner_name, owner_document

        def check_user():
            name = query_executor.simple_consult_query(name_query)
            name = query_executor.treat_simple_result(name, to_remove_list)

            sex = query_executor.simple_consult_query(sex_query)
            sex = query_executor.treat_simple_result(sex, to_remove_list)

            return name, sex

        def show_user(name, sex):
            if sex == "M":
                st.image(image="{}/library/images/man.png".format(absolute_app_path))
            elif sex == "F":
                st.image(image="{}/library/images/woman.png".format(absolute_app_path))
            st.text(body="{}".format(name))
            st.divider()

        def get_login():
            col1, col2, col3 = st.columns(3)

            with col1:
                st.write("")

            with col2:
                st.header(body=":dollar: Controle Financeiro")

                with st.container():
                    with st.expander(label=":computer: Login", expanded=True):
                        user = st.text_input(":closed_lock_with_key: Usuário")
                        password = st.text_input(":key: Senha", type="password")
                        login_button = st.button(label=":unlock: Entrar")

                        if login_button:
                            if validate_login(user, password):
                                with st.spinner("Aguarde..."):
                                    sleep(1)
                                    st.toast("Login bem-sucedido!")
                                    sleep(1)
                                    with open("data/cache/session_state.py", "w") as session:
                                        session.write("logged_user = '{}'".format(user))
                                        session.write("\nlogged_user_password = '{}'".format(password))

                                    st.session_state.is_logged_in = True
                                    st.rerun()

                            else:
                                st.error("Login falhou. Verifique suas credenciais.")

            with col3:
                st.write("")

        self.get_login = get_login
        self.show_user = show_user
        self.check_user = check_user
        self.get_doc_name = get_user_doc_name
