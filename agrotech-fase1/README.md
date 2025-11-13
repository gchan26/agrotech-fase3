# 🌾 AgroTech Manager — Controle Agrícola em Python + R

Gerencie culturas agrícolas (🍊 **laranja** e 🌱 **cana-de-açúcar**) com entrada de dados via terminal, exportação em CSV e relatórios estatísticos automáticos em **R**.

> **Stack:** Python (CLI + CSV) • R (readr + estatísticas)  
> **Plataformas:** Windows, macOS, Linux  
> **Formato dos dados:** CSV (UTF-8)

---

## ✨ Recursos

- ✅ **Entrada guiada** por menu (CLI) para cadastrar áreas e insumos  
- 💾 **Persistência automática** em CSV por cultura e consolidado  
- 🔁 **Atualizar/editar/deletar** registros específicos ou limpar tudo  
- 📊 **R Reports**: estatísticas descritivas por cultura e gerais (média, mediana, desvio, quartis, min/max)  
- 🚫 **Anti-duplicação** ao carregar CSVs  
- 🔡 **Suporte a acentuação** (UTF-8) e cabeçalhos com unidade (ex.: `Área (m²)`)

---

## 🗂️ Estrutura de Arquivos

```
.
├── agrotech_manager.py                 # Script Python (CLI principal)
├── estatisticas.R                      # Relatórios automáticos em R (sem interação)
├── calculadora.R                       # Calculadora estatística interativa em R
├── dados-agricolas.csv                 # Gerado pelo app (opcional)
└── README.md
```

---

## 🏁 Pré-requisitos

### Python
- **Python 3.10+** (usa `match/case`)
- Bibliotecas padrão: `csv`, `os` (sem dependências externas)

### R
- **R 4.x**
- Pacote: `readr`

```r
install.packages("readr")
```

---

## ⚙️ Instalação & Execução

### 1) Python (CLI de cadastro/gestão)
```bash
# macOS / Linux
python3 agrotech_manager.py

# Windows (se tiver o Python no PATH)
python agrotech_manager.py
```

Menu principal (exemplo):
```
1 - Inserir dados
2 - Mostrar dados
3 - Atualizar dados
4 - Deletar dados
5 - Sair
```

### 2) R (relatórios/estatísticas)

#### Estatísticas automáticas
Executa todos os relatórios de uma vez:
```bash
Rscript estatisticas.R
```

#### Calculadora estatística interativa
Abre um menu no terminal para escolher relatórios específicos:
```bash
Rscript calculadora.R
```

---

## 🧩 Fluxo de Uso (Python)

1. **Inserir dados**  
   - Escolha a cultura:  
     - `[1] Laranja (área retangular)`  
     - `[2] Cana-de-açúcar (área quadrada)`  
   - Informe medidas, tipo de insumo e dados do plantio  
   - O app calcula automaticamente a **área (m²)** e o **total de insumo (KG)**  
   - O registro é salvo em memória e no CSV.

2. **Mostrar dados**  
   - Visualize todos os registros ou escolha um índice específico.

3. **Atualizar dados**  
   - Escolha o índice do registro e refaça a inserção.

4. **Deletar dados**  
   - Apague registros específicos ou limpe todos os dados (por cultura ou geral).

---

## 📦 Formato dos CSVs

Cabeçalho **exato** (com acentos e unidades):

```csv
Cultura,Área (m²),Total Insumo (KG)
Laranja,1200,450
Cana-de-açúcar,900,315
```

Arquivos gerados:
- `dados-agricolas-laranja.csv`
- `dados-agricolas-cana-de-acucar.csv`  *(sem cedilha no nome do arquivo)*
- `dados-agricolas-todas-culturas.csv`

---

## 📈 Relatórios (R)

Os scripts em R utilizam `readr` e permitem duas formas de análise:

- **`estatisticas.R`** → relatório completo automático por cultura + geral  
- **`calculadora.R`** → menu interativo com opções:
  - Relatório completo  
  - Estatísticas por cultura  
  - Estatísticas gerais  
  - Recarregar dados  

### Exemplos dentro do R
```r
# Carregar dados
dados <- carregar_dados()

# Estatísticas automáticas
gerar_relatorio_completo(dados)

# Estatísticas por cultura
calcular_estatisticas(dados, "Área (m²)", cultura = "Laranja")

# Estatísticas gerais
calcular_estatisticas(dados, "Total Insumo (KG)")
```

---
