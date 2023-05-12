## Descrição

Esse repositório foi criado para testes de Change Data Capture utilizando o Debezium.
Você pode acompanhar a postagem para maiores detalhes: https://thedataengineer.com.br/2023/05/12/change-data-capture-com-debezium/

## Setup

Comando para preparar o ambiente:

    make k8s-setup

Comando para destruir o ambiente:

    make k8s-destroy

## Acessando o Kafka UI 

Redirecionar a porta para o localhost com o comando abaixo:

    make k8s-kui-pf

Kafka UI: http://localhost:8080

## Acessando o Debezium

Redirecionar a porta para o localhost com o comando abaixo:

    make k8s-dbz-pf

Debezium: http://localhost:8083

## Cadastrando o conector do exemplo via POST:

- Method: POST  Endpoint: http://localhost:8083/connectors
    - Example Body:
    ```json
    {
        "name": "postgres-connector",
        "config": {
            "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
            "database.hostname": "postgres-svc.ns-dbz-data-engineer.svc.cluster.local",
            "database.port": "5432",
            "database.user": "postgres",
            "database.password": "postgres",
            "database.dbname" : "debezium_db",
            "database.server.name": "postgres",        
            "table.include.list": "public.CUSTOMERS",
            "plugin.name": "pgoutput"
        }
    }
    ```    

