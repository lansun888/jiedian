{\rtf1\ansi\ansicpg936\cocoartf2708
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fmodern\fcharset0 Courier;\f1\fnil\fcharset134 PingFangSC-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs26 \cf0 \expnd0\expndtw0\kerning0
#!/bin/bash\
\
# 
\f1 \'bc\'ec\'b2\'e9\'ca\'c7\'b7\'f1\'d2\'d4
\f0 root
\f1 \'d3\'c3\'bb\'a7\'d4\'cb\'d0\'d0\'bd\'c5\'b1\'be
\f0 \
if [ "$(id -u)" != "0" ]; then\
    echo "
\f1 \'b4\'cb\'bd\'c5\'b1\'be\'d0\'e8\'d2\'aa\'d2\'d4
\f0 root
\f1 \'d3\'c3\'bb\'a7\'c8\'a8\'cf\'de\'d4\'cb\'d0\'d0\'a1\'a3
\f0 "\
    echo "
\f1 \'c7\'eb\'b3\'a2\'ca\'d4\'ca\'b9\'d3\'c3
\f0  'sudo -i' 
\f1 \'c3\'fc\'c1\'ee\'c7\'d0\'bb\'bb\'b5\'bd
\f0 root
\f1 \'d3\'c3\'bb\'a7\'a3\'ac\'c8\'bb\'ba\'f3\'d4\'d9\'b4\'ce\'d4\'cb\'d0\'d0\'b4\'cb\'bd\'c5\'b1\'be\'a1\'a3
\f0 "\
    exit 1\
fi\
\
# 
\f1 \'bc\'ec\'b2\'e9\'b2\'a2\'b0\'b2\'d7\'b0
\f0  Node.js 
\f1 \'ba\'cd
\f0  npm\
function install_nodejs_and_npm() \{\
    if command -v node > /dev/null 2>&1; then\
        echo "Node.js 
\f1 \'d2\'d1\'b0\'b2\'d7\'b0
\f0 "\
    else\
        echo "Node.js 
\f1 \'ce\'b4\'b0\'b2\'d7\'b0\'a3\'ac\'d5\'fd\'d4\'da\'b0\'b2\'d7\'b0
\f0 ..."\
        curl -fsSL https://deb.nodesource.com/setup_16.x | sbash -\
        apt-get install -y nodejs\
    fi\
\
    if command -v npm > /dev/null 2>&1; then\
        echo "npm 
\f1 \'d2\'d1\'b0\'b2\'d7\'b0
\f0 "\
    else\
        echo "npm 
\f1 \'ce\'b4\'b0\'b2\'d7\'b0\'a3\'ac\'d5\'fd\'d4\'da\'b0\'b2\'d7\'b0
\f0 ..."\
        apt-get install -y npm\
    fi\
\}\
\
# 
\f1 \'bc\'ec\'b2\'e9\'b2\'a2\'b0\'b2\'d7\'b0
\f0  PM2\
function install_pm2() \{\
    if command -v pm2 > /dev/null 2>&1; then\
        echo "PM2 
\f1 \'d2\'d1\'b0\'b2\'d7\'b0
\f0 "\
    else\
        echo "PM2 
\f1 \'ce\'b4\'b0\'b2\'d7\'b0\'a3\'ac\'d5\'fd\'d4\'da\'b0\'b2\'d7\'b0
\f0 ..."\
        npm install pm2@latest -g\
    fi\
\}\
\
# 
\f1 \'bc\'ec\'b2\'e9
\f0 Go
\f1 \'bb\'b7\'be\'b3
\f0 \
function check_go_installation() \{\
    if command -v go > /dev/null 2>&1; then\
        echo "Go 
\f1 \'bb\'b7\'be\'b3\'d2\'d1\'b0\'b2\'d7\'b0
\f0 "\
        return 0 \
    else\
        echo "Go 
\f1 \'bb\'b7\'be\'b3\'ce\'b4\'b0\'b2\'d7\'b0\'a3\'ac\'d5\'fd\'d4\'da\'b0\'b2\'d7\'b0
\f0 ..."\
        return 1 \
    fi\
\}\
\
# 
\f1 \'bd\'da\'b5\'e3\'b0\'b2\'d7\'b0\'b9\'a6\'c4\'dc
\f0 \
function install_node() \{\
    install_nodejs_and_npm\
    install_pm2\
\
    # 
\f1 \'b8\'fc\'d0\'c2\'ba\'cd\'b0\'b2\'d7\'b0\'b1\'d8\'d2\'aa\'b5\'c4\'c8\'ed\'bc\'fe
\f0 \
    apt update && apt upgrade -y\
    apt install -y curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev lz4 snapd\
\
    # 
\f1 \'b0\'b2\'d7\'b0
\f0  Go\
    if ! check_go_installation; then\
        rm -rf /usr/local/go\
        curl -L https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | tar -xzf - -C /usr/local\
        echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile\
        source $HOME/.bash_profile\
        go version\
    fi\
\
    # 
\f1 \'b0\'b2\'d7\'b0\'cb\'f9\'d3\'d0\'b6\'fe\'bd\'f8\'d6\'c6\'ce\'c4\'bc\'fe
\f0 \
    git clone https://github.com/initia-labs/initia\
    cd initia\
    git checkout v0.2.14\
    make install\
    initiad version\
\
    # 
\f1 \'c5\'e4\'d6\'c3
\f0 initiad\
    initiad init "Moniker" --chain-id initiation-1\
    initiad config set client chain-id initiation-1\
\
    # 
\f1 \'bb\'f1\'c8\'a1\'b3\'f5\'ca\'bc\'ce\'c4\'bc\'fe\'ba\'cd\'b5\'d8\'d6\'b7\'b2\'be
\f0 \
    wget -O $HOME/.initia/config/genesis.json https://initia.s3.ap-southeast-1.amazonaws.com/initiation-1/genesis.json\
    wget -O $HOME/.initia/config/addrbook.json https://rpc-initia-testnet.trusted-point.com/addrbook.json\
    sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \\"0.15uinit,0.01uusdc\\"|" $HOME/.initia/config/app.toml\
\
    # 
\f1 \'c5\'e4\'d6\'c3\'bd\'da\'b5\'e3
\f0 \
    PEERS="40d3f977d97d3c02bd5835070cc139f289e774da@168.119.10.134:26313,841c6a4b2a3d5d59bb116cc549565c8a16b7fae1@23.88.49.233:26656,e6a35b95ec73e511ef352085cb300e257536e075@37.252.186.213:26656,2a574706e4a1eba0e5e46733c232849778faf93b@84.247.137.184:53456,ff9dbc6bb53227ef94dc75ab1ddcaeb2404e1b0b@178.170.47.171:26656,edcc2c7098c42ee348e50ac2242ff897f51405e9@65.109.34.205:36656,07632ab562028c3394ee8e78823069bfc8de7b4c@37.27.52.25:19656,028999a1696b45863ff84df12ebf2aebc5d40c2d@37.27.48.77:26656,140c332230ac19f118e5882deaf00906a1dba467@185.219.142.119:53456,1f6633bc18eb06b6c0cab97d72c585a6d7a207bc@65.109.59.22:25756,065f64fab28cb0d06a7841887d5b469ec58a0116@84.247.137.200:53456,767fdcfdb0998209834b929c59a2b57d474cc496@207.148.114.112:26656,093e1b89a498b6a8760ad2188fbda30a05e4f300@35.240.207.217:26656,12526b1e95e7ef07a3eb874465662885a586e095@95.216.78.111:26656"\
    sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.initia/config/config.toml\
\
    # 
\f1 \'c5\'e4\'d6\'c3\'b6\'cb\'bf\'da
\f0 \
    node_address="tcp://localhost:53457"\
    sed -i -e "s%^proxy_app = \\"tcp://127.0.0.1:26658\\"%proxy_app = \\"tcp://127.0.0.1:53458\\"%; s%^laddr = \\"tcp://127.0.0.1:26657\\"%laddr = \\"tcp://127.0.0.1:53457\\"%; s%^pprof_laddr = \\"localhost:6060\\"%pprof_laddr = \\"localhost:53460\\"%; s%^laddr = \\"tcp://0.0.0.0:26656\\"%laddr = \\"tcp://0.0.0.0:53456\\"%; s%^prometheus_listen_addr = \\":26660\\"%prometheus_listen_addr = \\":53466\\"%" $HOME/.initia/config/config.toml\
    sed -i -e "s%^address = \\"tcp://localhost:1317\\"%address = \\"tcp://0.0.0.0:53417\\"%; s%^address = \\":8080\\"%address = \\":53480\\"%; s%^address = \\"localhost:9090\\"%address = \\"0.0.0.0:53490\\"%; s%^address = \\"localhost:9091\\"%address = \\"0.0.0.0:53491\\"%; s%:8545%:53445%; s%:8546%:53446%; s%:6065%:53465%" $HOME/.initia/config/app.toml\
    echo "export initiad_RPC_PORT=$node_address" >> $HOME/.bash_profile\
    source $HOME/.bash_profile   \
\
    # 
\f1 \'c5\'e4\'d6\'c3\'d4\'a4\'d1\'d4\'bb\'fa
\f0 \
    git clone https://github.com/skip-mev/slinky.git\
    cd slinky\
\
    # checkout proper version\
    git checkout v0.4.3\
    \
    make build\
\
    # 
\f1 \'c5\'e4\'d6\'c3\'d4\'a4\'d1\'d4\'bb\'fa\'c6\'f4\'d3\'c3
\f0 \
    sed -i -e 's/^enabled = "false"/enabled = "true"/' \\\
       -e 's/^oracle_address = ""/oracle_address = "127.0.0.1:8080"/' \\\
       -e 's/^client_timeout = "2s"/client_timeout = "500ms"/' \\\
       -e 's/^metrics_enabled = "false"/metrics_enabled = "false"/' $HOME/.initia/config/app.toml\
    \
    pm2 start initiad -- start && pm2 save && pm2 startup\
\
    pm2 stop initiad\
    \
    # 
\f1 \'c5\'e4\'d6\'c3\'bf\'ec\'d5\'d5
\f0 \
    sudo apt install lz4 -y\
    curl -L http://95.216.228.91/initia_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.initia\
    mv $HOME/.initia/priv_validator_state.json.backup $HOME/.initia/data/priv_validator_state.json\
    \
    pm2 start ./build/slinky -- --oracle-config-path ./config/core/oracle.json --market-map-endpoint 0.0.0.0:53490\
    pm2 restart initiad\
\
    echo '====================== 
\f1 \'b0\'b2\'d7\'b0\'cd\'ea\'b3\'c9
\f0 ,
\f1 \'c7\'eb\'cd\'cb\'b3\'f6\'bd\'c5\'b1\'be\'ba\'f3\'d6\'b4\'d0\'d0
\f0  source $HOME/.bash_profile 
\f1 \'d2\'d4\'bc\'d3\'d4\'d8\'bb\'b7\'be\'b3\'b1\'e4\'c1\'bf
\f0 ==========================='\
\}\
\
# 
\f1 \'b2\'e9\'bf\'b4
\f0 initia 
\f1 \'b7\'fe\'ce\'f1\'d7\'b4\'cc\'ac
\f0 \
function check_service_status() \{\
    pm2 list\
\}\
\
# initia 
\f1 \'bd\'da\'b5\'e3\'c8\'d5\'d6\'be\'b2\'e9\'d1\'af
\f0 \
function view_logs() \{\
    pm2 logs initiad\
\}\
\
# 
\f1 \'d0\'b6\'d4\'d8\'bd\'da\'b5\'e3\'b9\'a6\'c4\'dc
\f0 \
function uninstall_node() \{\
    echo "
\f1 \'c4\'e3\'c8\'b7\'b6\'a8\'d2\'aa\'d0\'b6\'d4\'d8
\f0 initia 
\f1 \'bd\'da\'b5\'e3\'b3\'cc\'d0\'f2\'c2\'f0\'a3\'bf\'d5\'e2\'bd\'ab\'bb\'e1\'c9\'be\'b3\'fd\'cb\'f9\'d3\'d0\'cf\'e0\'b9\'d8\'b5\'c4\'ca\'fd\'be\'dd\'a1\'a3
\f0 [Y/N]"\
    read -r -p "
\f1 \'c7\'eb\'c8\'b7\'c8\'cf
\f0 : " response\
\
    case "$response" in\
        [yY][eE][sS]|[yY]) \
            echo "
\f1 \'bf\'aa\'ca\'bc\'d0\'b6\'d4\'d8\'bd\'da\'b5\'e3\'b3\'cc\'d0\'f2
\f0 ..."\
            pm2 stop initiad && pm2 delete initiad\
            rm -rf $HOME/.initiad && rm -rf $HOME/initia $(which initiad) && rm -rf $HOME/.initia\
            echo "
\f1 \'bd\'da\'b5\'e3\'b3\'cc\'d0\'f2\'d0\'b6\'d4\'d8\'cd\'ea\'b3\'c9\'a1\'a3
\f0 "\
            ;;\
        *)\
            echo "
\f1 \'c8\'a1\'cf\'fb\'d0\'b6\'d4\'d8\'b2\'d9\'d7\'f7\'a1\'a3
\f0 "\
            ;;\
    esac\
\}\
\
# 
\f1 \'b4\'b4\'bd\'a8\'c7\'ae\'b0\'fc
\f0 \
function add_wallet() \{\
    initiad keys add wallet\
\}\
\
# 
\f1 \'b5\'bc\'c8\'eb\'c7\'ae\'b0\'fc
\f0 \
function import_wallet() \{\
    initiad keys add wallet --recover\
\}\
\
# 
\f1 \'b2\'e9\'d1\'af\'d3\'e0\'b6\'ee
\f0 \
function check_balances() \{\
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'c7\'ae\'b0\'fc\'b5\'d8\'d6\'b7
\f0 : " wallet_address\
    initiad query bank balances "$wallet_address" --node $initiad_RPC_PORT\
\}\
\
# 
\f1 \'b2\'e9\'bf\'b4\'bd\'da\'b5\'e3\'cd\'ac\'b2\'bd\'d7\'b4\'cc\'ac
\f0 \
function check_sync_status() \{\
    initiad status --node $initiad_RPC_PORT | jq .sync_info\
\}\
\
# 
\f1 \'b4\'b4\'bd\'a8\'d1\'e9\'d6\'a4\'d5\'df
\f0 \
function add_validator() \{\
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'c4\'fa\'b5\'c4\'c7\'ae\'b0\'fc\'c3\'fb\'b3\'c6
\f0 : " wallet_name\
    \
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'c4\'fa\'cf\'eb\'c9\'e8\'d6\'c3\'b5\'c4\'d1\'e9\'d6\'a4\'d5\'df\'b5\'c4\'c3\'fb\'d7\'d6
\f0 : " validator_name\
    \
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'c4\'fa\'b5\'c4\'d1\'e9\'d6\'a4\'d5\'df\'cf\'ea\'c7\'e9\'a3\'a8\'c0\'fd\'c8\'e7
\f0 '
\f1 \'b5\'f5\'c3\'ab\'d7\'ca\'b1\'be
\f0 '
\f1 \'a3\'a9
\f0 : " details\
\
\
    initiad tx mstaking create-validator   --amount=1000000uinit   --pubkey=$(initiad tendermint show-validator)   --moniker=$validator_name   --chain-id=initiation-1   --commission-rate=0.05   --commission-max-rate=0.10   --commission-max-change-rate=0.01   --from=$wallet_name   --identity=""   --website=""   --details=""   --gas=2000000 --fees=300000uinit --node $initiad_RPC_PORT \
  \
\}\
\
# 
\f1 \'b8\'f8\'d7\'d4\'bc\'ba\'b5\'d8\'d6\'b7\'d1\'e9\'d6\'a4\'d5\'df\'d6\'ca\'d1\'ba
\f0 \
function delegate_self_validator() \{\
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'d6\'ca\'d1\'ba\'b4\'fa\'b1\'d2\'ca\'fd\'c1\'bf
\f0 ,
\f1 \'b1\'c8\'c8\'e7\'c4\'e3\'d3\'d0
\f0 1
\f1 \'b8\'f6
\f0 init,
\f1 \'c7\'eb\'ca\'e4\'c8\'eb
\f0 1000000
\f1 \'a3\'ac\'d2\'d4\'b4\'cb\'c0\'e0\'cd\'c6
\f0 : " math\
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'c7\'ae\'b0\'fc\'c3\'fb\'b3\'c6
\f0 : " wallet_name\
    initiad tx mstaking delegate $(initiad keys show wallet --bech val -a) $\{math\}uinit --from $wallet_name --chain-id initiation-1 --gas=2000000 --fees=300000uinit --node $initiad_RPC_PORT -y\
\}\
\
function unjail() \{\
    read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'c7\'ae\'b0\'fc\'c3\'fb\'b3\'c6
\f0 : " wallet_name\
    initiad tx slashing unjail --from $wallet_name --fees=10000amf --chain-id=initiation-1 --node $initiad_RPC_PORT\
\}\
\
# 
\f1 \'b5\'bc\'b3\'f6\'d1\'e9\'d6\'a4\'d5\'df
\f0 key\
function export_priv_validator_key() \{\
    echo "====================
\f1 \'c7\'eb\'bd\'ab\'cf\'c2\'b7\'bd\'cb\'f9\'d3\'d0\'c4\'da\'c8\'dd\'b1\'b8\'b7\'dd\'b5\'bd\'d7\'d4\'bc\'ba\'b5\'c4\'bc\'c7\'ca\'c2\'b1\'be\'bb\'f2\'d5\'df
\f0 excel
\f1 \'b1\'ed\'b8\'f1\'d6\'d0\'bc\'c7\'c2\'bc
\f0 ==========================================="\
    cat ~/.initia/config/priv_validator_key.json\
    \
\}\
\
function update_node() \{\
cd $HOME\
cd initia\
git fetch --tags\
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)\
if [ -z "$latest_tag" ]; then\
    echo "
\f1 \'ce\'b4\'d5\'d2\'b5\'bd\'d7\'ee\'d0\'c2\'b5\'c4\'b1\'ea\'c7\'a9\'a1\'a3
\f0 "\
    exit 1\
fi\
\
git checkout $latest_tag\
make install\
pm2 restart initiad\
\
echo "
\f1 \'c9\'fd\'bc\'b6\'b5\'bd\'d7\'ee\'d0\'c2\'b0\'e6\'b1\'be
\f0  $latest_tag 
\f1 \'cd\'ea\'b3\'c9\'a1\'a3
\f0 "\
\
\}\
\
# 
\f1 \'d6\'f7\'b2\'cb\'b5\'a5
\f0 \
function main_menu() \{\
    while true; do\
        clear\
        echo "================================================================"\
        echo "
\f1 \'cd\'cb\'b3\'f6\'bd\'c5\'b1\'be\'a3\'ac\'c7\'eb\'b0\'b4\'bc\'fc\'c5\'cc
\f0 ctrl c
\f1 \'cd\'cb\'b3\'f6\'bc\'b4\'bf\'c9
\f0 "\
        echo "
\f1 \'c7\'eb\'d1\'a1\'d4\'f1\'d2\'aa\'d6\'b4\'d0\'d0\'b5\'c4\'b2\'d9\'d7\'f7
\f0 :"\
        echo "1. 
\f1 \'b0\'b2\'d7\'b0\'bd\'da\'b5\'e3
\f0 "\
        echo "2. 
\f1 \'b4\'b4\'bd\'a8\'c7\'ae\'b0\'fc
\f0 "\
        echo "3. 
\f1 \'b5\'bc\'c8\'eb\'c7\'ae\'b0\'fc
\f0 "\
        echo "4. 
\f1 \'b2\'e9\'bf\'b4\'c7\'ae\'b0\'fc\'b5\'d8\'d6\'b7\'d3\'e0\'b6\'ee
\f0 "\
        echo "5. 
\f1 \'b2\'e9\'bf\'b4\'bd\'da\'b5\'e3\'cd\'ac\'b2\'bd\'d7\'b4\'cc\'ac
\f0 "\
        echo "6. 
\f1 \'b2\'e9\'bf\'b4\'b5\'b1\'c7\'b0\'b7\'fe\'ce\'f1\'d7\'b4\'cc\'ac
\f0 "\
        echo "7. 
\f1 \'d4\'cb\'d0\'d0\'c8\'d5\'d6\'be\'b2\'e9\'d1\'af
\f0 "\
        echo "8. 
\f1 \'d0\'b6\'d4\'d8\'bd\'da\'b5\'e3
\f0 "\
        echo "9. 
\f1 \'c9\'e8\'d6\'c3\'bf\'ec\'bd\'dd\'bc\'fc
\f0 "  \
        echo "10. 
\f1 \'b4\'b4\'bd\'a8\'d1\'e9\'d6\'a4\'d5\'df
\f0 "  \
        echo "11. 
\f1 \'b8\'f8\'d7\'d4\'bc\'ba\'d6\'ca\'d1\'ba
\f0 "\
        echo "12. 
\f1 \'ca\'cd\'b7\'c5\'b3\'f6\'bc\'e0\'d3\'fc
\f0 "\
        echo "13. 
\f1 \'b1\'b8\'b7\'dd\'d1\'e9\'d6\'a4\'d5\'df\'cb\'bd\'d4\'bf
\f0 " \
        echo "14. 
\f1 \'c9\'fd\'bc\'b6\'bd\'da\'b5\'e3
\f0 " \
        read -p "
\f1 \'c7\'eb\'ca\'e4\'c8\'eb\'d1\'a1\'cf\'ee\'a3\'a8
\f0 1-12
\f1 \'a3\'a9
\f0 : " OPTION\
\
        case $OPTION in\
        1) install_node ;;\
        2) add_wallet ;;\
        3) import_wallet ;;\
        4) check_balances ;;\
        5) check_sync_status ;;\
        6) check_service_status ;;\
        7) view_logs ;;\
        8) uninstall_node ;;\
        9) check_and_set_alias ;;\
        10) add_validator ;;\
        11) delegate_self_validator ;;\
        12) unjail ;;\
        13) export_priv_validator_key ;;\
        14) update_node ;;\
        *) echo "
\f1 \'ce\'de\'d0\'a7\'d1\'a1\'cf\'ee\'a1\'a3
\f0 " ;;\
        esac\
        echo "
\f1 \'b0\'b4\'c8\'ce\'d2\'e2\'bc\'fc\'b7\'b5\'bb\'d8\'d6\'f7\'b2\'cb\'b5\'a5
\f0 ..."\
        read -n 1\
    done\
\}\
\
# 
\f1 \'cf\'d4\'ca\'be\'d6\'f7\'b2\'cb\'b5\'a5 \'d6\'c2\'be\'b4\'b4\'f3\'b6\'c4\'b8\'e7
\f0 \
main_menu\
}