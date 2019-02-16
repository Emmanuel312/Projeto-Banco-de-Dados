-- as tabelas devem ser dropadas na ordem inversa que foram criadas
DROP TABLE tb_compra;
DROP TABLE tb_encantamento;
DROP TABLE tb_negocia;
DROP TABLE tb_item;
DROP TABLE tb_secao;
DROP TABLE tb_cadastro;
DROP TABLE tb_loja;
DROP TABLE tb_barganha;
DROP TABLE tb_rota;
DROP TABLE tb_caravana;
DROP TABLE tb_cliente_comum;
DROP TABLE tb_reino;

CREATE TABLE tb_reino OF tp_reino (
    PRIMARY KEY (nome_reino),
    nome_rei NOT NULL,
    tamanho_hect NOT NULL
);
--T

CREATE TABLE tb_cliente_comum OF tp_cliente_comum(
    PRIMARY KEY (codigo),
    idade NOT NULL,
    sx NOT NULL,
    raca NOT NULL
);
--T

CREATE TABLE tb_caravana OF tp_caravana(
    PRIMARY KEY (codigo),
    FOREIGN KEY (ref_reino) REFERENCES tb_reino,
    condutor NOT NULL,
    veiculo NOT NULL,
    qtdComerciantes NOT NULL
);


CREATE TABLE tb_rota OF tp_rota(
    PRIMARY KEY (orig_dest),
    tipo_estrada NOT NULL,
    tamanho_km NOT NULL
);
--T

CREATE TABLE tb_barganha OF tp_barganha(
    PRIMARY KEY (pk_caravana_venda, pk_caravana_compra),
    FOREIGN KEY (ref_caravana_compra) REFERENCES tb_caravana, 
    FOREIGN KEY (ref_caravana_venda) REFERENCES tb_caravana
);

CREATE TABLE tb_loja OF tp_loja(
    PRIMARY KEY (endereco.rua, endereco.numero),
    nome_dono NOT NULL,
    nome_loja NOT NULL
);

CREATE TABLE tb_cadastro OF tp_cadastro(
    PRIMARY KEY(pk_loja.rua, pk_loja.numero, pk_cliente),
    FOREIGN KEY(ref_loja) REFERENCES tb_loja,
    FOREIGN KEY(ref_cliente) REFERENCES tb_cliente_comum
);
 
CREATE TABLE tb_secao OF tp_secao(
    PRIMARY KEY (tipo),
    FOREIGN KEY (ref_loja) REFERENCES tb_loja,
    tamanho NOT NULL,
    num_func NOT NULL
);

CREATE TABLE tb_item OF tp_item(
    PRIMARY KEY (codigo, pk_tipo),
    FOREIGN KEY (ref_secao) REFERENCES tb_secao,
    nome UNIQUE,
    quant NOT NULL,
    preco NOT NULL
);

CREATE TABLE tb_negocia OF tp_negocia(
    data_hora NOT NULL,
    PRIMARY KEY (pk_caravanba, pk_item_cod, pk_item_tipo),
    FOREIGN KEY (ref_item) REFERENCES tb_item,
    FOREIGN KEY (ref_caravana) REFERENCES tb_caravana,
    FOREIGN KEY (ref_rota) REFERENCES tb_rota
);

CREATE TABLE tb_encantamento OF tp_encantamento(
    PRIMARY KEY (e_id),
    nome NOT NULL UNIQUE
) NESTED TABLE buff STORE AS tb_buff_encantamento;

CREATE TABLE tb_compra OF tp_compra(
    PRIMARY KEY (data_hora, pk_item_cod, pk_item_tipo, pk_cliente_comum),
    FOREIGN KEY (ref_item) REFERENCES tb_item,
    FOREIGN KEY (ref_cliente_comum) REFERENCES tb_cliente_comum,
    FOREIGN KEY (ref_encantamento) REFERENCES tb_encantamento
);