import streamlit as st
from functions.user.login import User
from screens.app import HomePage


def main():

    st.set_page_config(page_title='Controle Financeiro', page_icon=':moneybag:', layout="wide", initial_sidebar_state="auto", menu_items=None)

    hide_streamlit_style = """
                <style>
                #MainMenu {visibility: hidden;}
                footer {visibility: hidden;}
                </style>
                """
    st.markdown(hide_streamlit_style, unsafe_allow_html=True)

    if 'is_logged_in' not in st.session_state:
        st.session_state.is_logged_in = False

    if st.session_state.is_logged_in:
        HomePage()
    else:
        call_user = User()
        call_user.get_login()
        
if __name__ == "__main__":
    main()
