import matplotlib.pyplot as plt


# Query para gerar a lista dos 10 artistas mais premiados
def query_1(cursor):
    # Esta query usa a função COUNT para contar os prêmios vencidos de um artista, fazendo um JOIN com as tabelas
    # PARTICIPACOES e PREMIO. Ela então agrupa pelo Nome_artistico, ordena decrescentemente pelo total de prêmios
    # vencidos, e retorna os 10 artistas que mais venceram prêmios.
    cursor.execute('''SELECT
                            P.Nome_artistico,
                            COUNT(PR.ID_premio) AS total_premios_vencidos
                        FROM
                            PESSOAS P
                        LEFT JOIN
                            PARTICIPACOES PA ON P.Nome_artistico = PA.Nome_artistico
                        LEFT JOIN
                            PREMIO PR ON PA.ID_participacao = PR.ID_pessoa_vencedora
                        GROUP BY
                            P.Nome_artistico
                        ORDER BY
                            total_premios_vencidos DESC
                        LIMIT 10;
                    ''')

    dados = cursor.fetchall()

    # Separando os dados em listas para facilitar o plot
    artistas, contagens = zip(*dados)

    # Criando o histograma
    plt.bar(artistas, contagens, color='blue')

    # Configurando os ticks do eixo y para serem inteiros
    plt.yticks(range(int(min(contagens)), int(max(contagens)) + 1))

    # Adicionando rótulos ao gráfico
    plt.xlabel('Artistas')
    plt.ylabel('Nº de Prêmios')
    plt.title('Histograma de Artistas Mais Premiados')

    # Exibindo o gráfico
    plt.xticks(rotation=90)
    plt.subplots_adjust(bottom=0.5)
    plt.show()


# Query para gerar a lista dos 10 filmes mais premiados
def query_2(cursor):
    # Esta query também faz uso da função COUNT para contar o total de prêmios de cada filme. De forma semelhante, ela
    # ordena os resultados em ordem decrescente e seleciona os 10 primeiros valores.
    cursor.execute('''SELECT
                        F.Titulo_original,
                        COUNT(PM.ID_premio) AS TotalPremios
                    FROM
                        FILMES F
                        JOIN PREMIO PM ON F.ID_filme = PM.ID_filme_vencedor
                    GROUP BY
                        F.Titulo_original
                    ORDER BY
                        TotalPremios DESC
                    LIMIT 10;''')

    dados = cursor.fetchall()

    # Separando os dados em listas para facilitar o plot
    filmes, contagens = zip(*dados)

    # Criando o histograma
    plt.bar(filmes, contagens, color='blue', width=0.8)

    # Configurando os ticks do eixo y para serem inteiros
    plt.yticks(range(int(min(contagens)), int(max(contagens)) + 1))

    # Adicionando rótulos ao gráfico
    plt.xlabel('Filmes')
    plt.ylabel('Nº de Prêmios')
    plt.title('Histograma de Filmes Mais Premiados')

    # Exibindo o gráfico
    plt.xticks(rotation=90)
    plt.subplots_adjust(bottom=0.5)
    plt.show()


# Query para gerar a lista dos 10 filmes com maior arrecadação
def query_3(cursor):
    # Esta query retorna o título do filme e o seu valor de arrecadação total. Também os ordena de forma decrescente
    # e seleciona os 10 primeiros.
    cursor.execute('''SELECT
                                    Titulo_original,
                                    Arrecadacao_total
                                FROM
                                    FILMES
                                ORDER BY
                                    Arrecadacao_total DESC
                                LIMIT 10;
                                ''')

    dados = cursor.fetchall()

    # Extrai os números da parte decimal e os títulos
    # Isto é feito pois o SQL retorna os números da seguinte forma: Decimal(<número>). Os splits dentro do zip servem
    # para extrair o número de dentro dos parênteses.
    titulos, valores = zip(*[(titulo, float(str(valor).split('(')[-1].split(')')[0])) for titulo, valor in dados])

    # Cria o histograma
    plt.bar(titulos, valores, color='green')

    # Adiciona rótulos ao gráfico
    plt.xlabel('Filmes')
    plt.ylabel('Arrecadação')
    plt.title('Histograma de Arrecadação Total por Filmes')

    # Exibe o gráfico
    plt.xticks(rotation=90)
    plt.subplots_adjust(bottom=0.5)
    plt.show()


# Query para listar todos os atores já indicados como "Melhor ator" em todos os eventos existentes
def query_4(cursor):
    # Esta query usa a cláusula DISTINCT para selecionar apenas uma vez os atores listados pela query. Ela filtra
    # os prêmios pelos que tem o Tipo = "Melhor ator" e as participações que tem o Cargo = "Ator". Ela então retorna
    # O nome artístico do ator, o nome do evento e o ano da edição na qual ele foi indicado.
    cursor.execute('''SELECT DISTINCT
    P.Nome_artistico,
    E.Nome_evento,
    ED.Ano
FROM
    PARTICIPACOES P
    JOIN INDICACOES_PESSOA IP ON P.ID_participacao = IP.ID_participacao
    JOIN PREMIO PR ON IP.ID_premio = PR.ID_premio
    JOIN EDICAO ED ON PR.ID_edicao = ED.ID_edicao
    JOIN EVENTOS E ON ED.Nome_evento = E.Nome_evento
WHERE
    P.Cargo_filme = 'Ator' AND
    PR.Tipo = 'Melhor Ator';

                                ''')

    dados = cursor.fetchall()

    # A query retorna uma lista armazenada na variável "dados". O código itera sobre essa lista exibindo as informações
    # de cada ator
    for ator in dados:
        print(f"{ator[0]} (indicado na edição de {ator[2]} de {ator[1]})")


# Query para listar os indicados e vencedores de um prêmio
def query_5(cursor):
    # Recebe o input do usuário do ID do prêmio a ser buscado
    premio = int(input("Insira o ID do prêmio a ser buscado: "))

    # Esta query serve para verificar se o prêmio se refere a filmes ou a pessoas, utilizando a cláusula CASE. Ela então
    # retorna o valor "Filme" ou "Pessoa"
    cursor.execute(f'''SELECT 
                    CASE
                        WHEN ID_pessoa_vencedora IS NULL THEN 'Filme'
                        ELSE 'Pessoa'
                    END AS TipoVencedor
                FROM PREMIO
                WHERE ID_premio = {premio};
                ''')

    # 'resultado' armazena a resposta da query, ou seja, "Filme" ou "Pessoa"
    resultado = cursor.fetchall()[0][0]

    if resultado == "Pessoa":
        # Query que busca todas as indicações a um prêmio na tabela INDICACOES_PESSOA
        cursor.execute(f'''SELECT
                            P.Nome_artistico AS PessoaIndicada
                        FROM INDICACOES_PESSOA IP
                        JOIN PARTICIPACOES P ON IP.ID_participacao = P.ID_participacao
                        WHERE IP.ID_premio = {premio};''')

        atores = cursor.fetchall()

        print("Indicados:")

        for ator in atores:
            print(ator[0])

        # Query que retorna o nome artístico do vencedor de um prêmio
        cursor.execute(f'''SELECT
                            PP.Nome_artistico AS Vencedor
                        FROM PREMIO P
                        LEFT JOIN PARTICIPACOES PP ON P.ID_pessoa_vencedora = PP.ID_participacao
                        WHERE P.ID_premio = {premio};''')

        vencedor = cursor.fetchone()

        print(f"Vencedor: {vencedor[0]}")

    if resultado == "Filme":
        # Query que busca todos os filmes indicados a um prêmio na tabela INDICACOES_FILME
        cursor.execute(f'''SELECT
                            F.Titulo_original AS FilmeIndicado
                        FROM INDICACOES_FILME IFI
                        JOIN FILMES F ON IFI.ID_filme = F.ID_filme
                        JOIN PREMIO P ON IFI.ID_premio = P.ID_premio
                        WHERE P.ID_premio = {premio};
                            ''')

        filmes = cursor.fetchall()

        print("Indicados:")

        for filme in filmes:
            print(filme[0])

        # Query que busca o título do filme vencedor
        cursor.execute(f'''SELECT
                                F.Titulo_original AS FilmeVencedor
                            FROM PREMIO P
                            JOIN FILMES F ON P.ID_filme_vencedor = F.ID_filme
                            WHERE P.ID_premio = {premio};
                            ''')

        vencedor = cursor.fetchone()

        print(f"Vencedor: {vencedor[0]}")


# Mapa que relaciona cada função construída a um número
queries = {
    1: query_1,
    2: query_2,
    3: query_3,
    4: query_4,
    5: query_5
}
