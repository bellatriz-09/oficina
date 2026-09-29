USE oficina;

INSERT INTO cliente (nome, endereco, telefone) VALUES
('Ana Souza',     'Rua das Mangueiras, 120, Santarém-PA', '93991112222'),
('Carlos Lima',   'Av. Tapajós, 500, Santarém-PA',        '93991113333'),
('Beatriz Prado', 'Travessa das Flores, 78, Santarém-PA', '93991114444');

-- Ana (cliente 1) tem dois veículos, para testar o HAVING de clientes com mais de um veículo.
INSERT INTO veiculo (id_cliente, placa, modelo, marca) VALUES
(1, 'ABC1234', 'Gol',     'Volkswagen'),
(1, 'DEF5678', 'Onix',    'Chevrolet'),
(2, 'GHI9012', 'HB20',    'Hyundai'),
(3, 'JKL3456', 'Corolla', 'Toyota');

INSERT INTO equipe (nome_equipe) VALUES
('Equipe Alfa'),
('Equipe Beta');

-- Equipe Alfa tem dois mecânicos, para testar o HAVING de equipes com mais de um mecânico.
INSERT INTO mecanico (id_equipe, nome, endereco, especialidade) VALUES
(1, 'João Pedro',       'Rua A, 10, Santarém-PA', 'Motor'),
(1, 'Marcos Vinícius',  'Rua B, 20, Santarém-PA', 'Elétrica'),
(2, 'Paulo Henrique',   'Rua C, 30, Santarém-PA', 'Suspensão');

INSERT INTO servico (descricao, valor_referencia) VALUES
('Troca de óleo',                  80.00),
('Alinhamento e balanceamento',    120.00),
('Revisão elétrica',               150.00),
('Troca de pastilhas de freio',    100.00);

INSERT INTO peca (descricao, valor_unitario) VALUES
('Filtro de óleo',          35.00),
('Pastilha de freio (jogo)', 90.00),
('Bateria 60Ah',            320.00);

INSERT INTO ordem_servico (id_veiculo, id_equipe, data_emissao, valor, status, data_conclusao) VALUES
(1, 1, '2026-08-01', 235.00, 'concluida',    '2026-08-03'),
(2, 1, '2026-08-15', 190.00, 'concluida',    '2026-08-17'),
(3, 2, '2026-09-01', 470.00, 'em_execucao',  NULL),
(1, 1, '2026-09-20',  80.00, 'aberta',       NULL);

INSERT INTO item_servico (id_os, id_servico, valor_cobrado) VALUES
(1, 1,  80.00),   -- OS1: troca de óleo
(1, 2, 120.00),   -- OS1: alinhamento e balanceamento
(2, 4, 100.00),   -- OS2: troca de pastilhas de freio
(3, 3, 150.00),   -- OS3: revisão elétrica
(4, 1,  80.00);   -- OS4: troca de óleo

INSERT INTO item_peca (id_os, id_peca, quantidade, valor_cobrado) VALUES
(1, 1, 1,  35.00),  -- OS1: 1 filtro de óleo
(2, 2, 1,  90.00),  -- OS2: 1 jogo de pastilha
(3, 3, 1, 320.00);  -- OS3: 1 bateria
