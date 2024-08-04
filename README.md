## Sobre o projeto

Este repositório contém a construção de um banco de dados em SQL que armazena dados de um site de filmes e uma aplicação em Python para gerenciá-lo. A aplicação permite que valores sejam inseridos em qualquer tabela do banco de dados, e também a exibição de certos gráficos sobre os dados contidos na base.

## Estrutura do repositório
- **app.py:** Código que contém a classe `main`. Também contém a conexão com o servidor SQL e a construção do menu exibido ao usuário;
- **graficos.py:** Código que contém as funções necessárias para a plotagem de gráficos referentes aos dados armazenados no BD;
- **insercoes.py:** Código que contém as funções necessárias para a inserção de dados novos nas tabelas do banco de dados.

## Como usar

Para o uso do aplicativo, o banco de dados deve ser construído em um servidor local a partir do arquivo dump `dump_bd.sql`. Ele pode então ser iniciado através do seguinte comando no terminal:

        python app.py
