USE oficina;

SELECT descricao, valor_referencia
FROM servico;

SELECT id_os, data_emissao, data_conclusao
FROM ordem_servico
WHERE status = 'concluida';

SELECT id_os,
       id_peca,
       quantidade,
       valor_cobrado,
       (quantidade * valor_cobrado) AS subtotal
FROM item_peca;

SELECT descricao, valor_referencia
FROM servico
ORDER BY valor_referencia DESC;

SELECT eq.nome_equipe,
       COUNT(os.id_os) AS total_os
FROM equipe eq
JOIN ordem_servico os ON os.id_equipe = eq.id_equipe
GROUP BY eq.id_equipe, eq.nome_equipe
ORDER BY total_os DESC;

SELECT c.nome AS cliente,
       COUNT(v.id_veiculo) AS qtd_veiculos
FROM cliente c
JOIN veiculo v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(v.id_veiculo) > 1;

SELECT eq.nome_equipe,
       COUNT(m.id_mecanico) AS qtd_mecanicos
FROM equipe eq
JOIN mecanico m ON m.id_equipe = eq.id_equipe
GROUP BY eq.id_equipe, eq.nome_equipe
HAVING COUNT(m.id_mecanico) > 1;

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

SELECT s.descricao,
       COUNT(its.id_os) AS vezes_utilizado
FROM servico s
JOIN item_servico its ON its.id_servico = s.id_servico
GROUP BY s.id_servico, s.descricao
ORDER BY vezes_utilizado DESC;

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

SELECT nome, especialidade
FROM mecanico
WHERE especialidade = 'Motor';
