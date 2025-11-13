# Esse arquivo "estatisticas.r" é uma versão automática 
# que faz um relatório completo

library(readr)

carregar_dados <- function() {
  arquivo <- "dados-agricolas.csv"
  if (file.exists(arquivo)) {
    tryCatch({
      dados <- read_csv(arquivo, show_col_types = FALSE)
      cat("-> Dados carregados de", arquivo, "\n")
      return(unique(dados))
    }, error = function(e) {
      cat("-> Erro ao carregar", arquivo, ":", e$message, "\n")
      return(NULL)
    })
  } else {
    cat("-> Arquivo CSV principal não encontrado.\n")
    return(NULL)
  }
}

calcular_estatisticas <- function(dados, variavel, cultura = NULL) {
  if (is.null(dados) || nrow(dados) == 0) {
    cat("-> Não há dados para calcular estatísticas.\n")
    return(NULL)
  }
  
  if (!is.null(cultura)) {
    dados_filtrados <- dados[dados$Cultura == cultura, ]
    if (nrow(dados_filtrados) == 0) {
      cat("-> Não há dados para a cultura:", cultura, "\n")
      return(NULL)
    }
    dados <- dados_filtrados
  }
  
  valores <- dados[[variavel]]
  
  if (length(valores) == 0) {
    cat("-> Não há valores para a variável:", variavel, "\n")
    return(NULL)
  }
  
  estatisticas <- list(
    n = length(valores),
    media = mean(valores, na.rm = TRUE),
    mediana = median(valores, na.rm = TRUE),
    desvio_padrao = sd(valores, na.rm = TRUE),
    variancia = var(valores, na.rm = TRUE),
    minimo = min(valores, na.rm = TRUE),
    maximo = max(valores, na.rm = TRUE),
    q1 = quantile(valores, 0.25, na.rm = TRUE),
    q3 = quantile(valores, 0.75, na.rm = TRUE)
  )
  
  return(estatisticas)
}

exibir_estatisticas <- function(estatisticas, titulo) {
  cat("\n", rep("=", 50), "\n")
  cat(titulo, "\n")
  cat(rep("=", 50), "\n")
  cat("Número de observações:", estatisticas$n, "\n")
  
  if (is.na(estatisticas$media)) {
    cat("Média: N/A\n")
  } else {
    cat("Média:", format(estatisticas$media, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  }
  
  if (is.na(estatisticas$mediana)) {
    cat("Mediana: N/A\n")
  } else {
    cat("Mediana:", format(estatisticas$mediana, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  }
  
  if (is.na(estatisticas$desvio_padrao)) {
    cat("Desvio Padrão: N/A (apenas uma observação)\n")
  } else {
    cat("Desvio Padrão:", format(estatisticas$desvio_padrao, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  }
  
  if (is.na(estatisticas$variancia)) {
    cat("Variância: N/A (apenas uma observação)\n")
  } else {
    cat("Variância:", format(estatisticas$variancia, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  }
  
  cat("Mínimo:", format(estatisticas$minimo, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  cat("Máximo:", format(estatisticas$maximo, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  cat("1º Quartil (Q1):", format(estatisticas$q1, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  cat("3º Quartil (Q3):", format(estatisticas$q3, big.mark = ".", decimal.mark = ",", digits = 2, nsmall = 1, scientific = FALSE), "\n")
  cat(rep("=", 50), "\n")
}

gerar_relatorio_completo <- function(dados) {
  if (is.null(dados)) return()
  
  cat("\n", rep("#", 60), "\n")
  cat("#", rep(" ", 18), "RELATÓRIO ESTATÍSTICO", rep(" ", 18), "#\n")
  cat("#", rep(" ", 58), "#\n")
  cat("#", rep(" ", 10), "ANÁLISE DE DADOS AGRÍCOLAS", rep(" ", 21), "#\n")
  cat(rep("#", 60), "\n")
  
  culturas <- unique(dados$Cultura)
  
  for (cultura in culturas) {
    cat("\n>>> CULTURA:", toupper(cultura), "\n")
    
    area_stats <- calcular_estatisticas(dados, "Área (m²)", cultura)
    if (!is.null(area_stats)) {
      exibir_estatisticas(area_stats, paste("ESTATÍSTICAS DE ÁREA -", cultura))
    }
    
    insumo_stats <- calcular_estatisticas(dados, "Total Insumo (KG)", cultura)
    if (!is.null(insumo_stats)) {
      exibir_estatisticas(insumo_stats, paste("ESTATÍSTICAS DE INSUMO -", cultura))
    }
  }
  
  cat("\n>>> ANÁLISE GERAL (TODAS AS CULTURAS)\n")
  
  area_geral <- calcular_estatisticas(dados, "Área (m²)")
  if (!is.null(area_geral)) {
    exibir_estatisticas(area_geral, "ESTATÍSTICAS GERAIS DE ÁREA")
  }
  
  insumo_geral <- calcular_estatisticas(dados, "Total Insumo (KG)")
  if (!is.null(insumo_geral)) {
    exibir_estatisticas(insumo_geral, "ESTATÍSTICAS GERAIS DE INSUMO")
  }
}

cat("=== CALCULADORA ESTATÍSTICA AGRÍCOLA ===\n")
cat("Carregando dados do arquivo CSV principal...\n")
dados <- carregar_dados()

if (!is.null(dados)) {
  gerar_relatorio_completo(dados)
} else {
  cat("-> Não foi possível carregar os dados. Verifique se o arquivo CSV existe.\n")
}
