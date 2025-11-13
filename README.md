# 🚀 Projeto PBL FarmTech Solutions | Fase 3: Integração com Oracle DB

## 🎯 Objetivo da Fase

A Fase 3 do Project-Based Learning (PBL) da **FarmTech Solutions** foca na **persistência de dados**. O objetivo principal é simular o **armazenamento** dos dados coletados pelos sensores agrícolas (da Fase 2) em um ambiente de produção real, utilizando o **Oracle Database** via **SQL Developer**.

Essa integração é o primeiro passo para preparar a base de dados que alimentará os futuros modelos de Inteligência Artificial.

---

### 🗄️ Dados de Origem e Esquema da Tabela

Os dados utilizados são provenientes de um arquivo CSV, simulando as leituras de sensores em diferentes fazendas. A tabela criada no banco de dados se chama **`FAZENDINHA_AGROTECH`**.

| Coluna | Descrição | Tipo de Dado (no DB) | Exemplo de Dado |
| :--- | :--- | :--- | :--- |
| **ID\_FAZENDA** | Identificador único da fazenda. | `NUMBER(38,0)` | 1 |
| **REGIAO** | Região geográfica da fazenda. | `VARCHAR2` | Sudeste |
| **CULTURA** | Tipo de cultura plantada. | `VARCHAR2` | Laranja |
| **PH** | Nível de pH do solo. | `NUMBER` | 6.2 |
| **UMIDADE** | Porcentagem de umidade do solo. | `NUMBER` | 18.5 |
| **TEMPERATURA** | Temperatura ambiente (°C). | `NUMBER` | 27 |
| **TIPO\_IRRIGACAO** | Método de irrigação utilizado. | `VARCHAR2` | Gotejamento |
| **TIPO\_FERTILIZANTE** | Tipo de insumo (adubo, fertilizante, defensor). | `VARCHAR2` | adubo |
| **AREA** | Área plantada. | `NUMBER` | 150000 |
| **DATA\_CRIACAO** | Data de criação do registro. | `DATE` | 2025-01-10 |

---

### ⚙️ Detalhamento da Importação no Oracle SQL Developer

A importação foi realizada seguindo as etapas do assistente de importação de dados do Oracle SQL Developer:

#### 1. Visualização de Dados (Etapa 1 de 4)

* **Ação:** Carregamento inicial do arquivo `dados-agricolas.csv`.
* **Configuração:** Reconhecimento automático do formato `CSV` e da codificação `UTF8`. O cabeçalho foi identificado corretamente, definindo os nomes das colunas de origem.
* **Print de Tela:** 

---

#### 2. Método de Importação (Etapa 2 de 4)

* **Ação:** Definição da estratégia de gravação dos dados no banco.
* **Nome da Tabela de Destino:** **`FAZENDINHA_AGROTECH`**
* **Método:** **`Inserir`** (Para criar a nova tabela e popular com os dados do arquivo).
* **Print de Tela:** 

---

#### 3. Escolher Colunas (Etapa 3 de 5)

* **Ação:** Seleção dos campos a serem incluídos na tabela.
* **Configuração:** Todas as 10 colunas disponíveis do CSV foram selecionadas para importação.
* **Print de Tela:** 

---

#### 4. Definição de Coluna (Etapa 4 de 5)

* **Ação:** Ajuste dos tipos de dados de cada coluna no banco de destino para garantir a integridade dos dados.
* **Exemplo:** A coluna **`ID_FAZENDA`** foi configurada como **`NUMBER`** com Precisão 38 e Escala 0 para armazenar o ID como um número inteiro.
* **Print de Tela:** 

---

#### 5. Conclusão e Confirmação

* **Ação:** Revisão final do resumo de importação e execução da tarefa.
* **Resultado:** A importação foi concluída com sucesso e o **commit** efetuado, indicando que os dados foram **salvos** permanentemente na tabela `FAZENDINHA_AGROTECH`.
* **Prints de Tela:**
    * 
    * 

---

### 📡 6. Correlação entre Hardware (ESP32) e Banco de Dados

A tabela **`FAZENDINHA_AGROTECH`** é a representação digital das leituras de campo. A Fase 2 demonstrou o protótipo de **hardware (ESP32)** que seria a fonte real dos dados importados para o Oracle na Fase 3.

---

#### 🧪 Fonte de Dados: ESP32 e Sensores

O circuito simulado na Fase 2 é composto por um **ESP32** e seus sensores/atuadores, que geram as informações-chave que preenchem nossa tabela:

* **DHT22 (Simulado):** Coleta a **Umidade** do solo.
* **Sensor de pH (Simulado):** Fornece a leitura do **pH do solo**.
* **Módulo Relé e Bomba (Simulado):** Atuador que controla a irrigação. O estado "Bomba LIGADA!" ou "Bomba DESLIGADA!" é a ação tomada com base no limite de umidade (ex: `umid>=60.00%`).
* **Lógicas de Botões (Simulado):** Representam os fatores que, junto com o pH, determinam a necessidade de insumos (**TIPO\_FERTILIZANTE**).

---

#### 📊 Mapeamento de Dados

Abaixo está como as leituras do ESP32 se traduzem nas colunas da nossa tabela `FAZENDINHA_AGROTECH`:

| Leitura do ESP32 (Console) | Coluna na Tabela Oracle | Detalhe da Correlação |
| :--- | :--- | :--- |
| **`Umidade: 68.5%`** | **UMIDADE** | Valor percentual direto do sensor. |
| **`pH=5.55` / `pH=0.22`** | **PH** | Valor de acidez/alcalinidade do solo. |
| **`Bomba LIGADA!` / `Bomba DESLIGADA!`** | **TIPO\_IRRIGACAO** | Indica o estado da ação tomada pelo microcontrolador. |
| **`N=FALTA` / `P=FALTA` / `K=FALTA`** | **TIPO\_FERTILIZANTE** | A lógica por trás desses indicadores simula a decisão de usar 'adubo', 'fertilizante' ou 'defensor' na fazenda. |

### 🎥 Demonstração Prática: Importação e Validação
Este vídeo apresenta a execução completa da Fase 3 do nosso PBL.

Ele detalha, passo a passo, o uso do Oracle SQL Developer para importar o arquivo de sensores agrícolas para a tabela FAZENDINHA_AGROTECH. O vídeo finaliza com a execução de uma consulta SQL (SELECT *) que valida o sucesso da importação e confirma o armazenamento dos dados, essenciais para as análises futuras de IA.
