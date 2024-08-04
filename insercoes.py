import mysql.connector


# Função que retorna o tipo da coluna
def tipo_col(cursor, tabela, coluna):
    # Criando a query
    query = ('SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS '
             f'WHERE TABLE_NAME = "{tabela}" AND COLUMN_NAME = "{coluna}"')

    # Executando consulta
    cursor.execute(query)

    resultado = cursor.fetchone()

    # Retorna o resultado da query
    return str(resultado[0])


# Cria query para inserir na tabela
def query_inserir(dic, tabela):
    # Transforma o nome das colunas numa string
    l1 = list(dic.keys())
    cols = '(' + ','.join(l1) + ')'

    # Transforma os valores a serem inseridos numa string
    l2 = list(dic.values())
    valores = '('
    for valor in l2:
        if valor is None:
            valores += "NULL"
        elif valor.isnumeric():
            valores += valor
        else:
            valores += f"'{valor}'"
        valores += ', '

    valores = valores[:-2] + ')'

    query = f'INSERT INTO {tabela} {cols}' \
            f'VALUES {valores}'

    return query


# Recebe o input do valor dependendo do tipo da coluna
def recebe_input(str_tipo, col):

    # Caso haja parênteses na string do tipo da coluna
    # (VARCHAR(), DECIMAL(), ENUM())
    if '(' in str_tipo:
        # Encontrando a posição dos parênteses
        abre_parenteses = str_tipo.find('(')
        fecha_parenteses = str_tipo.find(')')

        # Armazenando tipo
        tipo = str_tipo[0:abre_parenteses]

        # Extraindo a substring entre os parênteses
        conteudo_entre_parenteses = str_tipo[abre_parenteses + 1:fecha_parenteses]

        # Convertendo a string entre parênteses em uma lista
        valores = [valor.strip("'").strip() for valor in conteudo_entre_parenteses.split(',')]

        # DECIMAL(x, y)
        if tipo == "decimal":
            inp = input(f"Insira a parte inteira de {col}: ")

            # Se o input for vazio, retorna
            if not inp:
                return None

            parte_int = int(inp)

            # Checa se passou do limite de caracteres
            while len(str(parte_int)) > int(valores[0]):
                parte_int = int(input(
                    f"O valor inserido não pode ter mais que {valores[0]} caracteres. Tente novamente: "))

            inp = input(f"Insira a parte decimal de {col}: ")

            if not inp:
                inp = "0"

            parte_dec = int(inp)

            # Checa se passou do limite de caracteres
            while len(str(parte_dec)) > int(valores[1]):
                parte_dec = int(input(
                    f"O valor inserido não pode ter mais que {valores[1]} caracteres. Tente novamente: "))

            valor = str(parte_int) + "." + str(parte_dec)

        # ENUM(x, y, z...)
        if tipo == "enum":
            valor = input(f"Insira o valor de {col} {valores}: ")

            # Checa se o valor inserido é válido
            while valor not in valores:
                valor = input(f"O valor inserido deve ser um dos seguintes: {valores}. Tente novamente: ")

        # VARCHAR(x)
        if tipo == "varchar":
            valor = input(f"Insira o valor de {col}: ")

            # Checa se o input foi vazio
            if not valor:
                return None

            # Checa se o limite de caracteres foi ultrapassado
            while len(valor) > int(valores[0]):
                valor = input(f"O valor não pode ter mais que {valores[0]} caracteres. Tente novamente: ")

    # Caso NÃO haja parênteses
    # (INT, DATE)
    else:
        tipo = str_tipo

        # INT
        if tipo == "int":
            valor = input(f"Insira o valor de {col}: ")

            if not valor:
                return None

            valor = int(valor)

        # DATE
        if tipo == "date":
            dia = input(f"Insira o dia de {col} (1-31): ")

            if not dia:
                return None

            dia = int(dia)

            # Checa se o valor é um dia válido
            while dia < 1 or dia > 31:
                dia = int(input("Dia inválido. Tente novamente: "))

            mes = int(input(f"Insira o mês de {col} (1-12): "))

            # Checa se o valor é um mês válido
            while mes < 1 or mes > 12:
                mes = int(input("Mês inválido. Tente novamente: "))

            ano = int(input(f"Insira o ano de {col}: "))

            # Formata a data no formato 'YYYY-MM-DD'
            valor = f'{ano:04d}-{mes:02d}-{dia:02d}'

    return str(valor)


# Recebe inputs e retorna dicionário
def dict_inputs(cursor, tabela):
    dict = dict_tabelas[tabela]

    # Recebe o input para cada coluna da tabela
    for col in dict.keys():
        # Armazena o tipo da coluna
        tipo = tipo_col(cursor, tabela, col)

        # Lida com o tipo e armazena o input
        dict[col] = recebe_input(tipo, col)

    # Cria a query de inserção
    query = query_inserir(dict, tabela)

    # Executa
    try:
        cursor.execute(query)

        # Se a execução foi bem-sucedida
        print("Inserção realizada com sucesso.")

    except mysql.connector.Error as erro:
        # Tratamento de exceção para erros no MySQL
        print(f"Erro ao executar a query: {erro}")

        # Informações específicas sobre o erro
        print(f"Código do erro: {erro.errno}")
        print(f"Mensagem do erro: {erro.msg}")


# Dicionários das colunas das tabelas
dict_pessoas = {
    'Nome_artistico': None,
    'Nome_verdadeiro': None,
    'Sexo': None,
    'Ano_nascimento': None,
    'Site': None,
    'Ano_inicio': None,
    'Total_anos': None,
    'Situacao': None
}

dict_filmes = {
    'ID_filme': None,
    'Titulo_original': None,
    'Ano_producao': None,
    'Data_estreia': None,
    'Titulo_brasil': None,
    'Local_estreia': None,
    'Idioma_original': None,
    'Sala_exibicao': None,
    'Arrecadacao_primeiro_ano': None,
    'Arrecadacao_total': None,
    'Genero': None
}

dict_participacoes = {
    'ID_participacao': None,
    'Nome_artistico': None,
    'ID_filme': None,
    'Cargo_filme': None
}

dict_eventos = {
    'Nome_evento': None,
    'Nacionalidade': None,
    'Tipo': None,
    'Ano_inicio': None
}

dict_edicao = {
    'ID_edicao': None,
    'Nome_evento': None,
    'Localizacao': None,
    'Data': None
}

dict_premios = {
    'ID_premio': None,
    'ID_edicao': None,
    'ID_pessoa_vencedora': None,
    'ID_filme_vencedor': None,
    'Tipo': None,
    'Nome': None
}

dict_ind_pessoa = {
    'ID_indicacoes_pessoa': None,
    'ID_premio': None,
    'ID_participacao': None
}

dict_ind_filme = {
    'ID_indicacoes_filme': None,
    'ID_premio': None,
    'ID_filme': None
}

# Dicionário do menu de tabelas
dict_menu_tabelas = {
    "1": "PESSOAS",
    "2": "FILMES",
    "3": "PARTICIPACOES",
    "4": "EVENTOS",
    "5": "PREMIO",
    "6": "EDICAO",
    "7": "INDICACOES_PESSOA",
    "8": "INDICACOES_FILME"
}

# Dicionário de tabelas
dict_tabelas = {
    "PESSOAS": dict_pessoas,
    "FILMES": dict_filmes,
    "EVENTOS": dict_eventos,
    "PREMIO": dict_premios,
    "EDICAO": dict_edicao,
    "INDICACOES_PESSOA": dict_ind_pessoa,
    "INDICACOES_FILME": dict_ind_filme,
    "PARTICIPACOES": dict_participacoes
}
