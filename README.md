# Projeto: Gestão de Pedidos

![Relacionamentos e Cardinalidades](./Relacionamentos%20e%20Cardinalidades.drawio.png)
![MER DER Conceitual](./MER%20DER%20Conceitual.drawio.png)
![MER DER Lógico](./MER%20DER%20Lógico.drawio.png)

## Dicionário de Dados

| Entidade             | Atributo          | Tipo         | Tamanho | Descrição                                                     |
| :------------------- | :---------------- | :----------- | :------ | :------------------------------------------------------------ |
| **Categoria**        | id                | Inteiro      | 11      | Identificador, PK, Auto incrementável                         |
| **Categoria**        | nome              | Texto        | 100     | Nome da categoria do produto                                  |
| **Categoria**        | descricao         | Texto        | Text    | Descrição detalhada da categoria                              |
| **Fornecedor**       | id                | Inteiro      | 11      | Identificador, PK, Auto incrementável                         |
| **Fornecedor**       | razao_social      | Texto        | 150     | Razão social da empresa fornecedora                           |
| **Fornecedor**       | nome_fantasia     | Texto        | 150     | Nome fantasia do fornecedor                                   |
| **Fornecedor**       | cnpj              | Texto        | 18      | Número do CNPJ (único)                                        |
| **Fornecedor**       | telefone          | Texto        | 20      | Telefone de contato do fornecedor                             |
| **Fornecedor**       | email             | Texto        | 100     | E-mail de contato do fornecedor                               |
| **Fornecedor**       | endereco          | Texto        | 255     | Endereço completo do fornecedor                               |
| **Produto**          | id                | Inteiro      | 11      | Identificador, PK, Auto incrementável                         |
| **Produto**          | nome              | Texto        | 100     | Nome da peça de roupa                                         |
| **Produto**          | descricao         | Texto        | Text    | Descrição detalhada do produto                                |
| **Produto**          | preco             | Decimal      | 10,2    | Preço unitário de venda do produto                            |
| **Produto**          | marca             | Texto        | 50      | Marca do produto                                              |
| **Produto**          | id_categoria      | Inteiro      | 11      | Identificador da categoria, FK referenciando Categoria (id)   |
| **Produto**          | id_fornecedor     | Inteiro      | 11      | Identificador do fornecedor, FK referenciando Fornecedor (id) |
| **Estoque**          | id_estoque        | Inteiro      | 11      | Identificador, PK, Auto incrementável                         |
| **Estoque**          | id_produto        | Inteiro      | 11      | Identificador do produto, FK referenciando Produto (id)       |
| **Estoque**          | quantidade        | Inteiro      | 11      | Quantidade atual disponível em estoque                        |
| **Estoque**          | quantidade_minima | Inteiro      | 11      | Quantidade mínima de segurança em estoque                     |
| **Estoque**          | localizacao       | Texto        | 100     | Localização física do item (ex: Prateleira A1)                |
| **Movimentacao_Estoque** | id_movimentacao | Inteiro   | 11      | Identificador, PK, Auto incrementável                         |
| **Movimentacao_Estoque** | id_produto      | Inteiro      | 11      | Identificador do produto, FK referenciando Produto (id)       |
| **Movimentacao_Estoque** | tipo            | Texto (Enum) | 10      | Tipo da movimentação ('Entrada' ou 'Saída')                   |
| **Movimentacao_Estoque** | quantidade      | Inteiro      | 11      | Quantidade movimentada                                        |
| **Movimentacao_Estoque** | data            | Data/Hora    | Datetime| Data e hora do registro da movimentação                       |

## Dados de teste em CSV
- [categoria.csv](./csv/categoria.CSV)
- [estoque.csv](./csv/estoque.CSV)
- [fornecedor.csv](./csv/fornecedor.CSV)
- [movimentacao_estoque.csv](./csv/movimentacao_estoque.CSV)
- [produto.csv](./csv/produto.CSV)

## Script SQL DDL (Desenvolvimanto: Criação do Banco de dados)
```sql
drop database if exists gestao_estoque;
create database gestao_estoque;
use gestao_estoque;

create table categoria (
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text
);

create table fornecedor (
    id int not null primary key auto_increment,
    razao_social varchar(150) not null,
    nome_fantasia varchar(150),
    cnpj varchar(18) not null unique,
    telefone varchar(20),
    email varchar(100),
    endereco varchar(255)
);

create table produto (
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    preco decimal(10,2) not null,
    marca varchar(50),
    id_categoria int not null,
    id_fornecedor int not null
);

create table estoque (
    id_estoque int not null primary key auto_increment,
    id_produto int not null,
    quantidade int not null default 0,
    quantidade_minima int not null default 0,
    localizacao varchar(100)
);

create table movimentacao_estoque (
    id_movimentacao int not null primary key auto_increment,
    id_produto int not null,
    tipo enum('Entrada', 'Saída') not null,
    quantidade int not null,
    data datetime default current_timestamp
);

alter table produto add constraint fk_produto_categoria foreign key (id_categoria) references categoria(id);
alter table produto add constraint fk_produto_fornecedor foreign key (id_fornecedor) references fornecedor(id);

alter table estoque add constraint fk_estoque_produto foreign key (id_produto) references produto(id);

alter table movimentacao_estoque add constraint fk_movimentacao_produto foreign key (id_produto) references produto(id);

describe categoria;
describe fornecedor;
describe produto;
describe estoque;
describe movimentacao_estoque;
show tables;
```
## Script SQL DML(Manipulação: População com dados de teste)
```sql
use gestao_estoque;

insert into categoria (nome, descricao) values
('Camisetas', 'Camisetas masculinas e femininas'),
('Calças', 'Calça jeans e de moletom'),
('Meias', 'Meias do tamanho 32 ao 40'),
('Moletons', 'Moletons com e sem touca ');

insert into fornecedor (razao_social, nome_fantasia, cnpj, telefone, email, endereco) values
('Amapro LTDA', 'Amparo roupas', '12.345.678/0001-90', '19 3800-1122', 'amparo.roupas@email.com', 'Amparo_Sp'),
('Confeccoes Pignatas SA', 'Pignatas', '98.765.432/0001-10', '19 3800-3344', 'pignata.roupas@gmail.com', 'Amparo_Sp');

insert into produto (nome, descricao, preco, marca, id_categoria, id_fornecedor) values
('Camiseta de Algodão', 'Camiseta 100% algodão preta', 70.00, 'Nike', 1, 1),
('Calça Jeans', 'Calça jeans azul escuro modelagem slim', 150.00, 'Fofinha', 2, 1),
('Meias', 'Meia tamanho 40 branca', 40.00, 'Puma', 3, 2),
('Moletom sem touca', 'Moletom azul sem touca ', 200.00, 'Adidas', 4, 2);

insert into estoque (id_produto, quantidade, quantidade_minima, localizacao) values
(1, 50, 10, 'Prateleira 1'),
(2, 30, 5, 'Prateleira 2'),
(3, 15, 3, 'Prateleira 1'),
(4, 8, 2, 'Prateleira 1');

insert into movimentacao_estoque (id_produto, tipo, quantidade, data) values
(1, 'Entrada', 50, '2026-09-01'),
(2, 'Entrada', 30, '2026-09-02'),
(3, 'Entrada', 20, '2026-09-03'),
(3, 'Saída', 5, '2026-09-04'),
(4, 'Entrada', 8, '2026-09-05');

select * from categoria;
select * from fornecedor;
select * from produto;
select * from estoque;
select * from movimentacao_estoque;
```
