#!/bin/bash

red() {
    echo -e "\033[31m$1\033[0m"
}
green() {
    echo -e "\033[32m$1\033[0m"
}

blue() {
    echo -e "\033[34m$1\033[0m"
}

FOLDER=$(pwd)

while true; do
    blue "\nDigite a senha de root:"
    read -s root_password
    sleep 1
    blue "\nDigite a senha de root novamente: "
    read -s confirm_root_password
    sleep 1

    echo "$root_password" | sudo -S echo "Senha de root aceita."

    if [ $? -eq 0 ]; then
        green "\nVocê tem permissões de root. Continuando com o script..."
        sleep 1
        blue "\nInstalando dependências..."
        sleep 5
        apt install build-essential openssh-server git neofetch curl net-tools wget python3-venv python3-tk python3-pip python3.10-full python3.10-dev dkms perl gcc make default-libmysqlclient-dev libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev libncursesw5-dev llvm xz-utils tk-dev libffi-dev liblzma-dev python3-openssl -y
        ufw enable
        ufw allow 8501
        ufw allow OpenSSH
        break
    else
        red "\nSenha de root incorreta. Saindo..."
        sleep 1
        exit 1
    fi
done

sleep 1
clear

if ! command -v mysql &> /dev/null; then
    red "MySQL não está instalado. Instalando agora..."
    sleep 2
    sudo apt update && sudo apt install -y mysql-server
    if [ $? -ne 0 ]; then
        red "Erro ao instalar o MySQL. Saindo."
        exit 1
    fi
    green "MySQL instalado com sucesso."
fi

# Solicitar senha do usuário
while true; do
    blue "\nDefina a senha do banco de dados: "
    read -s password
    blue "\nRepita a senha: "
    read -s confirmation
    if [ "$password" = "$confirmation" ]; then
        green "\nSenhas coincidem. Verificando acesso ao MySQL..."
        sleep 2
        mysql -u root -p"$password" -e "QUIT" 2>/dev/null
        if [ $? -eq 0 ]; then
            green "Senha correta. Conexão com o MySQL estabelecida."
        else
            red "Senha incorreta ou não configurada. Configurando agora..."
            sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password'; FLUSH PRIVILEGES;"
            if [ $? -eq 0 ]; then
                green "Senha de root configurada com sucesso."
            else
                red "Erro ao configurar a senha de root. Saindo."
                exit 1
            fi
        fi
        break
    else
        red "\nAs senhas não coincidem. Tente novamente."
    fi
done

db_script="documentation/implantation_financas.sql"
if [ -f "$db_script" ]; then
    blue "\nExecutando script de implantação do banco de dados..."
    mysql -u root -p"$password" < "$db_script"
    if [ $? -eq 0 ]; then
        green "Script de implantação executado com sucesso."
    else
        red "Erro ao executar o script de implantação."
    fi
else
    red "Script de implantação não encontrado em '$db_script'."
fi

sleep 1
clear

cd $FOLDER
blue "\nCriando ambiente virtual..."
sleep 5
python3 -m venv venv
blue "\nAtivando ambiente virtual..."
sleep 5
source venv/bin/activate
pip install -r requirements.txt

sleep 1
clear

echo "#!/bin/bash" >> expenselit.sh
echo "cd $FOLDER" >> expenselit.sh
echo "source venv/bin/activate" >> expenselit.sh
echo "streamlit run main.py --server.port 8501" >> expenselit.sh
chmod u+x expenselit.sh
sudo mv expenselit.sh /usr/bin/

echo "[Unit]" >> expenselit.service
echo "Description=ExpenseLit - Controle Financeiro" >> expenselit.service
echo "[Service]" >> expenselit.service
echo "ExecStart=/usr/bin/expenselit.sh" >> expenselit.service
echo "[Install]" >> expenselit.service
echo "WantedBy=multi-user.target" >> expenselit.service
sudo mv expenselit.service /lib/systemd/system

sudo systemctl enable expenselit.service
sudo systemctl daemon-reload
sudo systemctl start expenselit.service

green "\nInstalação concluída."

link=$(python3 services/linux/get_ipv4.py)

sleep 5

blue "Você pode realizar o acesso a aplicação através dos seguintes links:\n"
green "$link"
