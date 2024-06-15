import streamlit as st
import subprocess
from dictionary.vars import server_config, dark_theme_config, light_theme_config, backup_sh_path, absolute_app_path
from data.cache.session_state import *
from time import sleep


class Config:
    def __init__(self):

        def theme_switcher(choosed):

            if choosed == 'dark':
                with open("{}/.streamlit/config.toml".format(absolute_app_path), "w") as arquivo:
                    arquivo.write("{}".format(dark_theme_config))
                    arquivo.write("{}".format(server_config))
                    sleep(2.5)

            elif choosed == 'light':
                with open("{}/.streamlit/config.toml".format(absolute_app_path), "w") as arquivo:
                    arquivo.write("{}".format(light_theme_config))
                    arquivo.write("{}".format(server_config))
                sleep(2.5)

        def data_backup():
            try:
                sleep(2)
                subprocess.run(['bash', backup_sh_path])
                st.success(body=":white_check_mark: Backup realizado com sucesso!")

            except Exception as error:
                st.warning(
                    body="Ocorreu um erro ao executar o arquivo .sh: {}".format(error))

        def show_configs():

            st.header(':wrench: Configurações')
            st.divider()

            col1, col2 = st.columns(2)

            with col1:

                st.subheader(body="Personalização")

                with st.expander(label="Aparência", expanded=True):

                    theme = st.radio(label=':art: Tema', options=[':sunny: Claro', ':new_moon: Escuro'])
                    confirm_button = st.button(label=':white_check_mark: Confirmar')

                    if confirm_button:
                        if theme == ':sunny: Claro':
                            theme_switcher(choosed='light')
                        if theme == ':new_moon: Escuro':
                            theme_switcher(choosed='dark')

                        with st.spinner(text='Aguarde...'):
                            sleep(1)
                            st.rerun()
            with col2:

                st.subheader(body="Backup de dados")

                with st.expander(label="Backup e Otimização", expanded=True):
                    
                    backup_button = st.button(label=":floppy_disk: Realizar backup de dados")

                    if backup_button:
                        with st.spinner(text="Aguarde..."):
                            sleep(1)
                            data_backup()
                            st.rerun()

        self.config = show_configs
