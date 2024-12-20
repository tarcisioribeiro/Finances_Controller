from screens.expenses.new_expense import NewCurrentExpense
from screens.expenses.new_credit_card_expense import NewCreditCardExpense
from screens.expenses.pay_credit_card_invoice import CreditCardInvoice
from screens.expenses.confirm_expense import ConfirmExpense
from screens.loans.pay_loan import PayLoan
import streamlit as st


class NewExpense:

    def __init__(self):

        def expenses_main_menu():

            col1, col2, col3 = st.columns(3)

            with col1:
                st.header(":money_with_wings: Nova Despesa")

            with col2:
                menu_options = {
                    "Despesa em Conta Corrente": NewCurrentExpense(),
                    "Despesa de Cartão": NewCreditCardExpense(),
                    "Pagar Fatura de Cartão": CreditCardInvoice(),
                    "Confirmar Pagamento": ConfirmExpense(),
                    "Pagar Valores em Aberto": PayLoan()
                }

                menu_choice = st.selectbox(label="Tipo de despesa", options=menu_options)

            st.divider()

            if menu_choice:
                call_interface = menu_options[menu_choice]
                call_interface.main_menu()

        self.main_menu = expenses_main_menu
