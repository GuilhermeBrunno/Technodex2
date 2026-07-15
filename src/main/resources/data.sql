-- ============================================================
-- Seed BAT Uberlândia
-- Dados para demonstração do sistema
-- ============================================================

-- ============================================================
-- SETORES
-- ============================================================

MERGE INTO setores (id, nome, descricao) KEY(id) VALUES (1, 'Producao', 'Linha de producao de cigarros');
MERGE INTO setores (id, nome, descricao) KEY(id) VALUES (2, 'Embalagem', 'Encaixotamento e embalagem secundaria');
MERGE INTO setores (id, nome, descricao) KEY(id) VALUES (3, 'Logistica', 'Esteiras e armazenagem de PA');
MERGE INTO setores (id, nome, descricao) KEY(id) VALUES (4, 'Utilidades', 'Vapor, ar comprimido e climatizacao');
MERGE INTO setores (id, nome, descricao) KEY(id) VALUES (5, 'Manutencao', 'Oficina e almoxarifado tecnico');

-- ============================================================
-- USUÁRIOS
-- Senha de todos: 123
-- ============================================================

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (1, 'lucaslopes', '{noop}123', 'Lucas Lopes', 'ADMIN', 5);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (2, 'joao.operador', '{noop}123', 'Joao Pedro', 'OPERADOR', 1);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (3, 'maria.operadora', '{noop}123', 'Maria Silva', 'OPERADOR', 2);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (4, 'carlos.tecnico', '{noop}123', 'Carlos Eduardo', 'TECNICO', 5);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (5, 'ana.tecnica', '{noop}123', 'Ana Costa', 'TECNICO', 5);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (6, 'pedro.lider', '{noop}123', 'Pedro Henrique', 'LIDER', 1);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (7, 'fernanda.especialista', '{noop}123', 'Fernanda Lima', 'ESPECIALISTA', 5);

MERGE INTO usuarios (id, login, senha, nome, tipo, setor_id) KEY(id)
VALUES (8, 'marcos.viewer', '{noop}123', 'Marcos Souza', 'VISUALIZADOR', 3);

-- ============================================================
-- MÁQUINAS
-- ============================================================

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (1, 'Embaladora Primaria 01', 'GD-XP', 'EP-001', 'OPERANDO', 1);

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (2, 'Maquina de Cortar 02', 'MCP-9', 'MC-002', 'OPERANDO', 1);

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (3, 'Encaixotadora 01', 'EC-2000', 'EX-003', 'OPERANDO', 2);

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (4, 'Esteira Transportadora 04', 'ET-50', 'ES-004', 'OPERANDO', 3);

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (5, 'Caldeira de Vapor', 'CV-1000', 'CA-005', 'OPERANDO', 4);

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (6, 'Compressor de Ar', 'CA-75', 'CP-006', 'OPERANDO', 4);

MERGE INTO maquinas (id, nome, modelo, numero_serie, status, setor_id) KEY(id)
VALUES (7, 'Paletizadora 01', 'PL-800', 'PA-007', 'OPERANDO', 2);

-- ============================================================
-- CHAMADOS
-- ============================================================

-- Aberto
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, data_abertura
) KEY(id)
VALUES (
1,
'Falha na Esteira',
'Esteira nao inicia.',
'ABERTO',
'MECANICA',
4,
CURRENT_TIMESTAMP
);

-- Em andamento
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, tecnico_id,
inicio_reparo, data_abertura
) KEY(id)
VALUES (
2,
'Motor superaquecendo',
'Temperatura acima do normal.',
'EM_ANDAMENTO',
'ELETRICA',
5,
4,
DATEADD('MINUTE',-15,CURRENT_TIMESTAMP),
DATEADD('MINUTE',-20,CURRENT_TIMESTAMP)
);

-- Pausado
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, tecnico_id,
inicio_reparo, inicio_pausa,
tempo_reparo_acumulado,
data_abertura
) KEY(id)
VALUES (
3,
'Sensor desalinhado',
'Aguardando chegada da peça.',
'PAUSADO',
'ELETRONICA',
3,
5,
DATEADD('MINUTE',-60,CURRENT_TIMESTAMP),
DATEADD('MINUTE',-20,CURRENT_TIMESTAMP),
2400,
DATEADD('HOUR',-2,CURRENT_TIMESTAMP)
);

-- Escalado
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, tecnico_id,
especialista_id,
data_abertura,
data_escalacao
) KEY(id)
VALUES (
4,
'Falha no CLP',
'Necessario suporte especializado.',
'ESCALADO',
'SOFTWARE',
2,
4,
7,
DATEADD('HOUR',-4,CURRENT_TIMESTAMP),
DATEADD('HOUR',-1,CURRENT_TIMESTAMP)
);

-- Concluído
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, tecnico_id,
data_abertura,
inicio_reparo,
data_conclusao,
tempo_reparo_acumulado,
tempo_locomocao_segundos
) KEY(id)
VALUES (
5,
'Troca de Correia',
'Correia rompida.',
'CONCLUIDO',
'MECANICA',
1,
4,
DATEADD('DAY',-2,CURRENT_TIMESTAMP),
DATEADD('DAY',-2,CURRENT_TIMESTAMP),
DATEADD('MINUTE',35,DATEADD('DAY',-2,CURRENT_TIMESTAMP)),
2100,
180
);

-- Concluído
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, tecnico_id,
data_abertura,
inicio_reparo,
data_conclusao,
tempo_reparo_acumulado,
tempo_locomocao_segundos
) KEY(id)
VALUES (
6,
'Ajuste Pneumatico',
'Vazamento de ar comprimido.',
'CONCLUIDO',
'PNEUMATICA',
6,
5,
DATEADD('DAY',-1,CURRENT_TIMESTAMP),
DATEADD('DAY',-1,CURRENT_TIMESTAMP),
DATEADD('MINUTE',20,DATEADD('DAY',-1,CURRENT_TIMESTAMP)),
1200,
90
);

-- Concluído
MERGE INTO chamados (
id, titulo, descricao, status, motivo_falha,
maquina_id, tecnico_id,
data_abertura,
inicio_reparo,
data_conclusao,
tempo_reparo_acumulado,
tempo_locomocao_segundos
) KEY(id)
VALUES (
7,
'Falha Eletrica',
'Disjuntor desarmando constantemente.',
'CONCLUIDO',
'ELETRICA',
7,
4,
DATEADD('DAY',-3,CURRENT_TIMESTAMP),
DATEADD('DAY',-3,CURRENT_TIMESTAMP),
DATEADD('MINUTE',18,DATEADD('DAY',-3,CURRENT_TIMESTAMP)),
1080,
120
);

-- ============================================================
-- NOTIFICAÇÕES (EXEMPLOS)
-- ============================================================

MERGE INTO notificacoes (
id, tipo, mensagem, data_envio, lida, chamado_id, usuario_id
) KEY(id)
VALUES (
1,
'CONCLUSAO',
'Chamado #5 concluido com sucesso.',
CURRENT_TIMESTAMP,
FALSE,
5,
1
);

MERGE INTO notificacoes (
id, tipo, mensagem, data_envio, lida, chamado_id, usuario_id
) KEY(id)
VALUES (
2,
'ESCALACAO',
'Chamado #4 foi escalado para um especialista.',
CURRENT_TIMESTAMP,
FALSE,
4,
1
);

MERGE INTO notificacoes (
id, tipo, mensagem, data_envio, lida, chamado_id, usuario_id
) KEY(id)
VALUES (
3,
'ALERTA_30MIN',
'Chamado #2 ultrapassou 30 minutos de reparo.',
CURRENT_TIMESTAMP,
FALSE,
2,
4
);