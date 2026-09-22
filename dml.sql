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