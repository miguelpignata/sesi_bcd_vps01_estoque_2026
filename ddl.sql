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