#!/bin/bash
# Script de Instalação Automática do Zabbix Server 7.4 no Oracle Linux 9 (RHEL-like)
# Database: MariaDB (MySQL)
# Web Server: Apache (httpd)

# --- VARIÁVEIS DE CONFIGURAÇÃO ---
DB_ROOT_PASSWORD="SuaSenhaRootDoBancoDeDados" # Altere!
ZABBIX_DB_NAME="zabbix"
ZABBIX_DB_USER="zabbix"
ZABBIX_DB_PASSWORD="SuaSenhaParaOUsuarioZabbix" # Altere!
ZABBIX_SERVER_IP="127.0.0.1" # IP do Zabbix Server (para o Agent)
GRAFANA_SERVER_IP="127.0.0.1" # IP do Grafana Server
# ---------------------------------

# Função para verificar o status do último comando
check_status() {
    if [ $? -ne 0 ]; then
        echo "ERRO: Ocorreu um erro no passo anterior. Saindo."
        exit 1
    fi
}

echo "--- 🛠️ INICIANDO INSTALAÇÃO AUTOMÁTICA DO ZABBIX 7.4 no Oracle Linux 9 ---"

## 1. Update do SO
echo "1/14: Update do SO"
#sudo dnf -y update
check_status
###########################################################################################################################################################
## 2. Instalar Repositório Zabbix
echo "2/14: Configurando o repositório Zabbix..."
sudo rpm -Uvh https://repo.zabbix.com/zabbix/7.4/release/oracle/9/noarch/zabbix-release-latest-7.4.el9.noarch.rpm
dnf clean all
check_status
###########################################################################################################################################################
## 3. Instalar Banco de Dados e Componentes Zabbix
echo "3/13: Instalando MariaDB, Zabbix Server, Frontend e Agent..."
sudo dnf install -y mariadb-server zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent httpd php-fpm
check_status
###########################################################################################################################################################
## 4. Configurar e Inicializar MariaDB (MySQL)
echo "4/14: Inicializando e configurando o MariaDB..."
sudo systemctl enable --now mariadb
check_status
###########################################################################################################################################################
## 5. Configurar Banco Zabbix no MariaDB (MySQL)

###########################################################################################################################################################
## 6. Configurar Zabbix Server
#echo "6/14: Configurando o arquivo zabbix_server.conf..."
#sudo sed -i "s/# DBPassword=/DBPassword=$ZABBIX_DB_PASSWORD/" /etc/zabbix/zabbix_server.conf
#sudo sed -i "s/# DBName=zabbix/DBName=$ZABBIX_DB_NAME/" /etc/zabbix/zabbix_server.conf
#sudo sed -i "s/# DBUser=zabbix/DBUser=$ZABBIX_DB_USER/" /etc/zabbix/zabbix_server.conf
#check_status
###########################################################################################################################################################
## 8. Configurar Zabbix Server
#echo "8/14: Configurando o arquivo zabbix_server.conf..."
#sudo sed -i "s/# DBPassword=/DBPassword=$ZABBIX_DB_PASSWORD/" /etc/zabbix/zabbix_server.conf
#sudo sed -i "s/# DBName=zabbix/DBName=$ZABBIX_DB_NAME/" /etc/zabbix/zabbix_server.conf
#sudo sed -i "s/# DBUser=zabbix/DBUser=$ZABBIX_DB_USER/" /etc/zabbix/zabbix_server.conf
#check_status
###########################################################################################################################################################
## 9. Configurar o PHP para o Frontend Web
#echo "9/14: Configurando o PHP (timezone) para o frontend web..."
# Substitua 'America/Sao_Paulo' pelo seu fuso horário, se necessário
#sudo sed -i 's/;date.timezone =/date.timezone = America\/Maceio/' /etc/php-fpm.d/zabbix.conf
#check_status
###########################################################################################################################################################
## 10. Configurar e Iniciar Serviços
#echo "10/14: Habilitando e iniciando os serviços Zabbix, Apache e PHP-FPM..."
#sudo systemctl enable zabbix-server.service
#sudo systemctl enable --now zabbix-agent.service
#sudo systemctl enable --now httpd
#sudo systemctl enable --now php-fpm
#check_status
###########################################################################################################################################################
## 11. Configurar Firewall (Firewalld)
#echo "11/14: Configurando o Firewall..."
#sudo firewall-cmd --add-service={http,https} --permanent
#sudo firewall-cmd --add-port=10050/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --add-port=10051/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --add-port=161/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --add-port=162/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --add-port=80/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --add-port=8080/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --add-port=443/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --reload
#check_status
###########################################################################################################################################################
## 12. Instalar Repositório Grafana
#echo "12/14: Configurando o Firewall..."
#echo "--- 🛠️ INICIANDO INSTALAÇÃO AUTOMÁTICA DO Grafana 12.2.0 no Oracle Linux 9 ---"
#sudo dnf install -y https://dl.grafana.com/grafana-enterprise/release/12.2.0/grafana-enterprise_12.2.0_17949786146_linux_amd64.rpm
###########################################################################################################################################################
## 11. Configurar Firewall (Firewalld)
#echo "13/14: Configurando o Firewall..."
#sudo firewall-cmd --add-port=3000/tcp --permanent  # Porta do Zabbix Server
#sudo firewall-cmd --reload
#check_status
###########################################################################################################################################################
## 14. Configurar e Iniciar Serviços
#echo "14/14: Habilitando e iniciando os serviços Zabbix, Apache e PHP-FPM..."
#sudo systemctl start grafana-server
#sudo systemctl enable --now grafana-server
#check_status
#systemctl start grafana-server
###########################################################################################################################################################
#echo "--- 🎉 INSTALAÇÃO CONCLUÍDA! ---"
#echo "O Zabbix Server 7.4 foi instalado com sucesso no seu Oracle Linux 9."
#echo ""
#echo "🔗 Próximo Passo: Acesse a interface web do Zabbix para finalizar a configuração:"
#echo "   http://$ZABBIX_SERVER_IP/zabbix"
#echo ""
#echo "   Usuário padrão: Admin"
#echo "   Senha padrão: zabbix"
#echo ""
#echo "O Grafana Server 12.2.0 foi instalado com sucesso no seu Oracle Linux 9."
#echo ""
#echo "🔗 Próximo Passo: Acesse a interface web do Zabbix para finalizar a configuração:"
#echo "   http://$GRAFANA_SERVER_IP:3000"
#echo ""
#echo "   Usuário padrão: admin"
#echo "   Senha padrão: admin"
#echo ""
#echo "⚠️ Não se esqueça de ALTERAR A SENHA padrão do Admin imediatamente!"
