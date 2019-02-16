
DROP TYPE tp_compra force;
DROP TYPE tp_encantamento force;
DROP TYPE tp_negocia force;
DROP TYPE tp_item force;
DROP TYPE tp_secao force;
DROP TYPE tp_cadastro force;
DROP TYPE tp_loja force;
DROP TYPE tp_barganha force;
DROP TYPE tp_rota force;
DROP TYPE tp_caravana force;
DROP TYPE tp_cliente_comum force;
DROP TYPE tp_cliente force;
DROP TYPE tp_reino force;
DROP TYPE tp_endereco force;
DROP TYPE tp_nt_buffs force;


--buffs como TABLE (nested table): não é preciso estabelecer um limite de buffs
CREATE OR REPLACE TYPE tp_nt_buffs AS TABLE OF VARCHAR2 (50);
/
--T

CREATE OR REPLACE TYPE tp_endereco AS OBJECT (
	rua VARCHAR2(100),
	numero NUMBER
) FINAL;
/
--T

CREATE OR REPLACE TYPE tp_reino AS OBJECT (
	nome_reino VARCHAR2(50),
	nome_rei VARCHAR2(50),
	tamanho_hect NUMBER
) FINAL;
/
--T

CREATE OR REPLACE TYPE tp_cliente AS OBJECT(
	codigo NUMBER,
	nome VARCHAR2(50),
	moeda VARCHAR2(50)
) NOT FINAL NOT INSTANTIABLE;
/
--T

CREATE OR REPLACE TYPE tp_cliente_comum UNDER tp_cliente(
	idade NUMBER,
	sx VARCHAR2(1),
	raca VARCHAR2(50)

) FINAL;
/
--T

CREATE OR REPLACE TYPE tp_caravana UNDER tp_cliente(
	condutor VARCHAR2(50),
	veiculo VARCHAR2(50),
	qtdComerciantes NUMBER,
	ref_reino REF tp_reino
) FINAL;
/


CREATE OR REPLACE TYPE tp_rota AS OBJECT(
	orig_dest VARCHAR2(100),
 	tipo_estrada VARCHAR2(50),
	tamanho_km NUMBER
) FINAL;
/
--T

CREATE OR REPLACE TYPE tp_barganha AS OBJECT(
	ref_caravana_compra REF tp_caravana,
	ref_caravana_venda REF tp_caravana,
	pk_caravana_venda NUMBER,
	pk_caravana_compra NUMBER
) FINAL;
/
 
CREATE OR REPLACE TYPE tp_loja AS OBJECT(
	endereco tp_endereco,
	nome_dono VARCHAR2(50),
	nome_loja VARCHAR2(50)
) FINAL;
/

CREATE OR REPLACE TYPE tp_cadastro AS OBJECT(
	ref_loja REF tp_loja,
	ref_cliente REF tp_cliente,
	pk_loja tp_endereco,
	pk_cliente NUMBER
) FINAL;
/

CREATE OR REPLACE TYPE tp_secao AS OBJECT(
	tipo VARCHAR2(50),
	tamanho NUMBER,
	num_func NUMBER,
	ref_loja REF tp_loja
) FINAL;
/

CREATE OR REPLACE TYPE tp_item AS OBJECT(
	codigo NUMBER,
	pk_tipo VARCHAR2(50),
	ref_secao REF tp_secao,
	nome VARCHAR2(50),
	quant NUMBER,
	preco DECIMAL(8,2)
) FINAL;
/

CREATE OR REPLACE TYPE tp_negocia AS OBJECT(
	data_hora TIMESTAMP,
	ref_item REF tp_item,
	ref_caravana REF tp_caravana,
	ref_rota REF tp_rota,
	pk_caravanba NUMBER,
	pk_item_cod NUMBER,
	pk_item_tipo VARCHAR2(50)
) FINAL;
/

CREATE OR REPLACE TYPE tp_encantamento AS OBJECT(
	e_id NUMBER,
	nome VARCHAR2(50),
	buff tp_nt_buffs
) FINAL;
/

CREATE OR REPLACE TYPE tp_compra AS OBJECT(
	data_hora TIMESTAMP,
	ref_item REF tp_item,
	ref_cliente_comum REF tp_cliente_comum,
	ref_encantamento REF tp_encantamento,
	taxa_extra DECIMAL(8,2),
	pk_cliente_comum NUMBER,
	pk_item_cod NUMBER,
	pk_item_tipo VARCHAR2(50)
) FINAL;
/