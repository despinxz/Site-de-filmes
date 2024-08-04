import insercoes as i
import graficos as g
import mysql.connector

# Dicionário do menu inicial
dict_menu_inicial = {
    "1": "Inserir valor no banco de dados",
    "2": "Exibir gráficos"
}


# Função que cria menu a partir de um dicionário
def menu(dict_menu):
    m = ""

    for num, valor in dict_menu.items():
        m += f"{num} - {valor}\n"

    inp = input(f"Selecione a tabela desejada: \n"
                f"{m}")

    while inp not in dict_menu.keys():
        print("Valor inválido.")
        inp = input(f"Selecione a tabela desejada: \n"
                    f"{m}")

    return dict_menu[inp]


# Função que conecta ao servidor
def conecta():
    try:
        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='bd1'
        )

        if cnx.is_connected():
            print("Conexão ao servidor realizada com sucesso.")
            return cnx

    except mysql.connector.Error as erro:
        print(f"Erro: {erro}")
        return


# Função para o menu de inserir em tabelas
def insercao(cursor):
    # Recebe input da tabela a ser inserida
    tabela = menu(i.dict_menu_tabelas)

    # Executa a inserção da linha
    i.dict_inputs(cursor, tabela)


# Main
if __name__ == '__main__':
    # Cria conexão
    cnx = conecta()
    cursor = cnx.cursor()

    # Menu
    opc = menu(dict_menu_inicial)

    if opc == "Inserir valor no banco de dados":
        insercao(cursor)

    if opc == "Exibir gráficos":
        num = int(input("Selecione a opção desejada:"
                        "\n1 - Gerar um histograma com os 10 atores/atrizes mais premiados"
                        "\n2 - Gerar um histograma com os 10 filmes mais premiados"
                        "\n3 - Gerar um histograma com os 10 filmes com maior arrecadação"
                        "\n4 - Listar todos os atores/atrizes já indicados como 'melhor ator' em todos os eventos existentes"
                        "\n5 - Listar os indicados e o vencedor de um determinado prêmio"
                        "\n"))

        while num not in range(1, 6):
            num = int(input("Opção inválida. Tente novamente: "))

        g.queries[num](cursor)
