--inserindo reinos (3)--inserindo reinos (3)
INSERT INTO tb_reino VALUES ('Reino A', 'Rei 1', 50);
INSERT INTO tb_reino VALUES ('Reino C', 'Rei 3', 75);
INSERT INTO tb_reino VALUES ('Reino B', 'Rei 2', 25);
--T

--inserindo clientes (5)
INSERT INTO tb_cliente_comum VALUES (1111, 'Joao', 'Moeda1', 25, 'M', 'Humano');
INSERT INTO tb_cliente_comum VALUES (2222, 'Maria', 'Moeda1', 34, 'F', 'Argonian');
INSERT INTO tb_cliente_comum VALUES (3333, 'Jose', 'Moeda2',45, 'M', 'Humano');
INSERT INTO tb_cliente_comum VALUES (4444, 'Carlos', 'Moeda1', 67, 'M', 'Orc');
INSERT INTO tb_cliente_comum VALUES (5555, 'Pedro', 'Moeda5', 13, 'M', 'Draenei');
--T

--inserindo caravanas (3)
INSERT INTO tb_caravana VALUES (6666, 'Caravana Legal', 'Moeda5', 'Jeremias', 'Carroça', 10, (SELECT REF(R) FROM tb_reino R WHERE nome_reino = 'Reino A'));
INSERT INTO tb_caravana VALUES (7777, 'Caravana Chata', 'Moeda1', 'Jorge', 'Trator', 10, (SELECT REF(R) FROM tb_reino R WHERE nome_reino = 'Reino B') );
INSERT INTO tb_caravana VALUES (8888, 'Caravana Media', 'Moeda2', 'Carla', 'Nave Espacial', 10, (SELECT REF(R) FROM tb_reino R WHERE nome_reino = 'Reino C'));
--T

--inserindo rotas (2)
INSERT INTO tb_rota VALUES ('Reino A - Reino C', 'Terra', 1000);
INSERT INTO tb_rota VALUES ('Reino C - Reino B', 'Pedra', 5000);
--T

--inserindo barganhas (3)
INSERT INTO tb_barganha VALUES (
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 6666),
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 7777),
    (SELECT C.codigo FROM tb_caravana C WHERE C.codigo = 6666),
    (SELECT C.codigo FROM tb_caravana C WHERE C.codigo = 7777)
);

INSERT INTO tb_barganha VALUES (
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 7777),
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 8888),
    (SELECT C.codigo FROM tb_caravana C WHERE C.codigo = 7777),
    (SELECT C.codigo FROM tb_caravana C WHERE C.codigo = 8888)
);

INSERT INTO tb_barganha VALUES (
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 8888),
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 6666),
    (SELECT C.codigo FROM tb_caravana C WHERE C.codigo = 8888),
    (SELECT C.codigo FROM tb_caravana C WHERE C.codigo = 6666)
);
--T

--inserindo lojas (5)
INSERT INTO tb_loja VALUES (
    tp_endereco('Rua qualquer', 45),
    'Seu Manoel',
    'Armazem do Seu Manoel'
);

INSERT INTO tb_loja VALUES (
    tp_endereco('Diagonal Alley', 12),
    'Garrick Olivaras',
    'Ollivanders'
);

INSERT INTO tb_loja VALUES (
    tp_endereco('Outra rua', 19),
    'Outro Cara',
    'Outra Loja'
);

INSERT INTO tb_loja VALUES (
    tp_endereco('Mais uma rua', 67),
    'Mais um dono da Silva',
    'Mais uma Loja'
);

INSERT INTO tb_loja VALUES (
    tp_endereco('Rua do cavalo', 33),
    'Seu Tonico',
    'Tonico Tônicos e Armaduras'
);
--T

--inserindo cadastros(3)
INSERT INTO tb_cadastro VALUES (
    (SELECT REF(L) FROM tb_loja L WHERE L.endereco = tp_endereco('Diagonal Alley', 12)),
    (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 1111),
    (SELECT L.endereco FROM tb_loja L WHERE L.endereco = tp_endereco('Diagonal Alley', 12)),
    (SELECT C.codigo FROM tb_cliente_comum C WHERE C.codigo = 1111)
);

INSERT INTO tb_cadastro VALUES (
    (SELECT REF(L) FROM tb_loja L WHERE L.endereco = tp_endereco('Outra rua', 19)),
    (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 3333),
    (SELECT L.endereco FROM tb_loja L WHERE L.endereco = tp_endereco('Outra rua', 19)),
    (SELECT C.codigo FROM tb_cliente_comum C WHERE C.codigo = 3333)
);

INSERT INTO tb_cadastro VALUES (
    (SELECT REF(L) FROM tb_loja L WHERE L.endereco = tp_endereco('Rua do cavalo', 33)),
    (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 5555),
    (SELECT L.endereco FROM tb_loja L WHERE L.endereco = tp_endereco('Rua do cavalo', 33)),
    (SELECT C.codigo FROM tb_cliente_comum C WHERE C.codigo = 5555)
);
--T

--inserindo secoes (3)
INSERT INTO tb_secao VALUES (
    'Armas',
    100,
    2,
    (SELECT REF(L) FROM tb_loja L WHERE L.endereco = tp_endereco('Diagonal Alley', 12))   
);

INSERT INTO tb_secao VALUES (
    'Armaduras',
    50,
    4,
    (SELECT REF(L) FROM tb_loja L WHERE L.endereco = tp_endereco('Outra rua', 19))
);

INSERT INTO tb_secao VALUES (
    'Amuletos',
    200,
    5,
    (SELECT REF(L) FROM tb_loja L WHERE L.endereco = tp_endereco('Rua do cavalo', 33))
);
--T

--inserindo itens (6)
INSERT INTO tb_item VALUES(1, 'Armas', (SELECT REF(T) FROM tb_secao T WHERE T.tipo = 'Armas'), 'Ventobravo^Knai', 50, 1500);
INSERT INTO tb_item VALUES(2, 'Armas', (SELECT REF(T) FROM tb_secao T WHERE T.tipo = 'Armas'), 'Rok Delar', 30, 700);
INSERT INTO tb_item VALUES(3, 'Armaduras', (SELECT REF(T) FROM tb_secao T WHERE T.tipo = 'Armaduras'), 'Armadura Mágica', 10, 530);
INSERT INTO tb_item VALUES(4, 'Armaduras', (SELECT REF(T) FROM tb_secao T WHERE T.tipo ='Armaduras'), 'Armadura de Arthas', 25, 4800);
INSERT INTO tb_item VALUES(5, 'Amuletos', (SELECT REF(T) FROM tb_secao T WHERE T.tipo = 'Amuletos'), 'Amuleto Contra Magias de Fogo', 3, 10000);
INSERT INTO tb_item VALUES(6, 'Amuletos', (SELECT REF(T) FROM tb_secao T WHERE T.tipo = 'Amuletos'), 'Amuleto de Proteção', 12, 150);

--inserindo negociacoes (2)
INSERT INTO tb_negocia VALUES(
    TO_DATE('13-07-1998', 'DD-MM-YYYY'),
    (SELECT REF(I) FROM tb_item I WHERE codigo = 1 AND  pk_tipo = 'Armas'),
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 6666),
    (SELECT REF(R) FROM tb_rota R WHERE R.orig_dest = 'Reino A - Reino C'),
    6666,
    1,
	'Armas'
);

INSERT INTO tb_negocia VALUES(
    TO_DATE('23-02-2005', 'DD-MM-YYYY'),
    (SELECT REF(I) FROM tb_item I WHERE codigo = 5 AND  pk_tipo = 'Amuletos'),
    (SELECT REF(C) FROM tb_caravana C WHERE C.codigo = 7777),
    (SELECT REF(R) FROM tb_rota R WHERE R.orig_dest = 'Reino C - Reino B'),
    7777,
	5,
	'Amuletos'
);

--inserindo encantamentos (4)
INSERT INTO tb_encantamento VALUES(
  377, 'Leto Enchant', tp_nt_buffs('Science +3')
);

INSERT INTO tb_encantamento VALUES(
  4703, 'Selene Enchant', tp_nt_buffs('Realistic +3')
);

INSERT INTO tb_encantamento VALUES(
  7035, 'Crius Enchant', tp_nt_buffs('Narrative +1')
);

INSERT INTO tb_encantamento VALUES(
  6892, 'Astraeus Enchant', tp_nt_buffs('Realistic +3', 'Science +3')
);


--inserindo compras (5)
INSERT INTO tb_compra VALUES (
  TO_TIMESTAMP('02-07-1115 10:38:17', 'DD-MM-YYYY HH24:MI:SS'),
  (SELECT REF(I) FROM tb_item I WHERE I.codigo = 1),
  (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 5555),
  (SELECT REF(E) FROM tb_encantamento E WHERE E.e_id = 377),
  NULL,
  5555,
  1,
  'Armas'
);

INSERT INTO tb_compra VALUES (
  TO_TIMESTAMP('01-02-1115 01:13:37', 'DD-MM-YYYY HH24:MI:SS'),
  (SELECT REF(I) FROM tb_item I WHERE I.codigo = 2),
  (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 1111)
  (SELECT REF(E) FROM tb_encantamento E WHERE E.e_id = 4703),
  NULL,
  1111,
  2,
  'Armas'
);

INSERT INTO tb_compra VALUES (
  TO_TIMESTAMP('03-04-1115 10:38:17', 'DD-MM-YYYY HH24:MI:SS'),
  (SELECT REF(I) FROM tb_item I WHERE I.codigo = 3),
  (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 2222)
  (SELECT REF(E) FROM tb_encantamento E WHERE E.e_id = 7035),
  NULL,
  2222,
  3,
  'Amuletos'
);

INSERT INTO tb_compra VALUES (
  TO_TIMESTAMP('02-03-1115 02:01:37', 'DD-MM-YYYY HH24:MI:SS'),
  (SELECT REF(I) FROM tb_item I WHERE I.codigo = 4),
  (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 3333)
  (SELECT REF(E) FROM tb_encantamento E WHERE E.e_id = 6892),
  NULL,
  3333,
  4,
  'Amuletos'
);

INSERT INTO tb_compra VALUES (
  TO_TIMESTAMP('06-05-1115 09:23:11', 'DD-MM-YYYY HH24:MI:SS'),
  (SELECT REF(I) FROM tb_item I WHERE I.codigo = 5),
  (SELECT REF(C) FROM tb_cliente_comum C WHERE C.codigo = 4444)
  (SELECT REF(E) FROM tb_encantamento E WHERE E.e_id = 377),
  NULL,
  4444,
  5,
  'Armaduras'
);
