import streamlit as st


class VarTests:

    def __init__(self):

        def var_details(variable):

            st.info(body="Tipo: {}.".format(type(variable).__name__))
                
            if type(variable).__name__ != 'bool' and type(variable).__name__ != 'date':
                st.info(body="Tamanho: {}.".format(len(variable)))

            st.info(body="Conteúdo: {}.".format(variable))

        def show_list_tuple_content(content_list: any):

            if type(content_list).__name__ != 'tuple' and type(content_list).__name__ != 'list':
                st.error(body="Erro.")
            
            elif type(content_list).__name__ == 'tuple' or type(content_list).__name__ == 'list':
                for i in range(0, len(content_list)):
                    st.info(body="Posição: {}.".format(i))
                    st.info(body="Tipo: {}.".format(type(content_list[i]).__name__))
                    st.info(body="Conteúdo: {}.".format(content_list[i]))

        self.var_details = var_details
        self.list_content = show_list_tuple_content