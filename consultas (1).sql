USE oficina;

-- ============================================================
-- 1) Recuperação simples — SELECT
-- Pergunta: quais serviços a oficina oferece e a que valor de referência?
-- ============================================================
SELECT descricao, valor_referencia
FROM servico;


-- ============================================================
-- 2) Filtro — WHERE
-- Pergunta: quais ordens de serviço já foram concluídas?
-- ============================================================
SELECT id_os, data_emissao, data_conclusao
FROM ordem_servico
WHERE status = 'concluida';


-- ============================================================
-- 3) Atributo derivado
-- Pergunta: qual o valor total de cada peça usada (quantidade x valor cobrado)?
-- ============================================================
SELECT id_os,
       id_peca,
       quantidade,
       valor_cobrado,
       (quantidade * valor_cobrado) AS subtotal
FROM item_peca;


-- ============================================================
-- 4) Ordenação — ORDER BY
-- Pergunta: quais os serviços do mais caro ao mais barato (valor de referência)?
-- ============================================================
SELECT descricao, valor_referencia
FROM servico
ORDER BY valor_referencia DESC;


-- ============================================================
-- 5) Quantas ordens de serviço cada equipe já executou?
-- (GROUP BY simples, sem filtro de grupo)
-- ============================================================
SELECT eq.nome_equipe,
       COUNT(os.id_os) AS total_os
FROM equipe eq
JOIN ordem_servico os ON os.id_equipe = eq.id_equipe
GROUP BY eq.id_equipe, eq.nome_equipe
ORDER BY total_os DESC;


-- ============================================================
-- 6) Filtro de grupo — HAVING
-- Pergunta: quais clientes têm mais de um veículo cadastrado?
-- ============================================================
SELECT c.nome AS cliente,
       COUNT(v.id_veiculo) AS qtd_veiculos
FROM cliente c
JOIN veiculo v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(v.id_veiculo) > 1;


-- ============================================================
-- 7) Filtro de grupo — HAVING
-- Pergunta: quais equipes têm mais de um mecânico?
-- ============================================================
SELECT eq.nome_equipe,
       COUNT(m.id_mecanico) AS qtd_mecanicos
FROM equipe eq
JOIN mecanico m ON m.id_equipe = eq.id_equipe
GROUP BY eq.id_equipe, eq.nome_equipe
HAVING COUNT(m.id_mecanico) > 1;


-- ============================================================
-- 8) Junção entre tabelas — JOIN
-- Pergunta: para cada OS, qual o veículo, o cliente dono do veículo,
-- a equipe responsável e o status atual?
-- ============================================================
SELECT os.id_os,
       v.placa,
       v.modelo,
       c.nome AS cliente,
       eq.nome_equipe,
       os.status
FROM ordem_servico os
JOIN veiculo v ON v.id_veiculo = os.id_veiculo
JOIN cliente c ON c.id_cliente = v.id_cliente
JOIN equipe eq ON eq.id_equipe = os.id_equipe
ORDER BY os.id_os;


-- ============================================================
-- 9) Qual serviço é mais utilizado entre as ordens de serviço?
-- ============================================================
SELECT s.descricao,
       COUNT(its.id_os) AS vezes_utilizado
FROM servico s
JOIN item_servico its ON its.id_servico = s.id_servico
GROUP BY s.id_servico, s.descricao
ORDER BY vezes_utilizado DESC;


-- ============================================================
-- 10) Combinando JOIN + atributo derivado + HAVING + ORDER BY
-- Pergunta: qual o valor total (serviços + peças) de cada OS,
-- considerando só as que ultrapassam R$150, do maior para o menor?
-- Usa subconsultas agregadas para não gerar produto cartesiano ao
-- juntar item_servico e item_peca na mesma OS.
-- ============================================================
SELECT os.id_os,
       COALESCE(s.total_servicos, 0) + COALESCE(p.total_pecas, 0) AS valor_total
FROM ordem_servico os
LEFT JOIN (
    SELECT id_os, SUM(valor_cobrado) AS total_servicos
    FROM item_servico
    GROUP BY id_os
) s ON s.id_os = os.id_os
LEFT JOIN (
    SELECT id_os, SUM(quantidade * valor_cobrado) AS total_pecas
    FROM item_peca
    GROUP BY id_os
) p ON p.id_os = os.id_os
HAVING valor_total > 150
ORDER BY valor_total DESC;


-- ============================================================
-- 11) Quais mecânicos têm especialidade em "Motor"?
-- ============================================================
SELECT nome, especialidade
FROM mecanico
WHERE especialidade = 'Motor';
