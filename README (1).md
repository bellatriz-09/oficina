# Projeto Lógico de Banco de Dados — Oficina Mecânica

Mapeamento do esquema conceitual da oficina mecânica (sistema de controle de ordens de serviço) para o **modelo lógico relacional**, com script de criação do esquema, massa de dados de teste e consultas SQL.

## Arquivos

| Arquivo | Conteúdo |
|---|---|
| `schema.sql` | DDL — criação de todas as tabelas, com PK e FK |
| `dados.sql` | Massa de dados de teste (INSERTs) |
| `consultas.sql` | Consultas SQL organizadas por cláusula, cada uma respondendo a uma pergunta de negócio |

## Do conceitual para o lógico

O modelo conceitual tinha as entidades Cliente, Veiculo, Equipe, Mecanico, OrdemServico, Servico e Peca, com dois relacionamentos N:N: OrdemServico×Servico e OrdemServico×Peca. No mapeamento para o modelo relacional:

- Cada entidade virou uma tabela, com uma chave primária (`id_*`) própria.
- Os relacionamentos 1:N (Cliente→Veiculo, Equipe→Mecanico, Veiculo→OrdemServico, Equipe→OrdemServico) viraram uma chave estrangeira do lado "N" apontando para a tabela do lado "1".
- Os dois relacionamentos N:N viraram tabelas associativas com **chave primária composta**:
  - `item_servico` (id_os, id_servico) — guarda `valor_cobrado`, já que o valor efetivamente cobrado pode diferir do valor de referência cadastrado em `servico`.
  - `item_peca` (id_os, id_peca) — guarda `quantidade` e `valor_cobrado`.
- O campo `valor` em `ordem_servico` guarda o total já fechado da OS (soma de serviços e peças), calculado no momento da emissão/conclusão.

## Como executar

```bash
mysql -u seu_usuario -p < schema.sql
mysql -u seu_usuario -p < dados.sql
mysql -u seu_usuario -p < consultas.sql
```

## Consultas incluídas

`consultas.sql` cobre, cada uma comentada com a pergunta que responde:
- Recuperação simples (`SELECT`)
- Filtros (`WHERE`)
- Atributos derivados (ex.: subtotal de peça = quantidade × valor cobrado)
- Ordenação (`ORDER BY`)
- Filtros de grupo (`HAVING`) — clientes com mais de um veículo, equipes com mais de um mecânico
- Junções entre tabelas (`JOIN`) — visão completa de cada OS (veículo, cliente, equipe, status), serviço mais utilizado, e valor total por OS combinando serviços e peças
