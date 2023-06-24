Provisionamento de um novo site
=======================


## Pacotes necessários:

* nginx
* Python 3.6
* virtualenv + pip
* Git


Por exemplo, no Ubuntu:

    sudo add-apt-repository ppa:fkrull/deadsnakes
    sudo apt-get install nginx git python36 python3.6-venv


## Config do Nginx Virtual Host


* veja nginx.template.conf
* substitua SITENAME, por exemplo, dev.precoemsuasmaos.com.br


## Serviço Systemd

* veja gunicorn-systemd.template.service
* substitua SITENAME, por exemplo, dev.precoemsuasmaos.com.br


## Estrutura de pastas:
Suponha que temos uma conta de usuário em /home/username


/home/username
|___ sites
     |___ SITENAME
            |___ database
            |___ source
            |___ static
            |___ virtualenv