-- Bora pro Rio: cole tudo isso no SQL Editor do Supabase e clique em Run.

create table if not exists places (
  id text primary key default gen_random_uuid()::text,
  name text not null check (char_length(name) between 1 and 80),
  category text not null default 'postal',
  area text default '' check (char_length(area) <= 60),
  note text default '' check (char_length(note) <= 280),
  link text default '' check (char_length(link) <= 300),
  added_by text default '',
  added_by_name text default '',
  created_at timestamptz not null default now()
);

create table if not exists votes (
  place_id text not null references places(id) on delete cascade,
  voter_id text not null,
  voter_name text not null default '',
  created_at timestamptz not null default now(),
  primary key (place_id, voter_id)
);

alter table places enable row level security;
alter table votes enable row level security;

-- Qualquer pessoa com o link pode ver, adicionar, votar e remover.
drop policy if exists "ler lugares" on places;
drop policy if exists "adicionar lugares" on places;
drop policy if exists "remover lugares" on places;
drop policy if exists "ler votos" on votes;
drop policy if exists "votar" on votes;
drop policy if exists "tirar voto" on votes;
drop policy if exists "trocar nome" on votes;
create policy "ler lugares" on places for select to anon using (true);
create policy "adicionar lugares" on places for insert to anon with check (true);
create policy "remover lugares" on places for delete to anon using (added_by <> 'lista');
create policy "ler votos" on votes for select to anon using (true);
create policy "votar" on votes for insert to anon with check (true);
create policy "tirar voto" on votes for delete to anon using (true);
create policy "trocar nome" on votes for update to anon using (true) with check (true);

insert into places (id, name, category, area, note, added_by) values
  ('s-praia-de-copacabana', 'Praia de Copacabana', 'praia', 'Copacabana', 'Calçadão de ondas, quiosques e mate com biscoito Globo.', 'lista'),
  ('s-praia-de-ipanema-posto-9', 'Praia de Ipanema (Posto 9)', 'praia', 'Ipanema', 'A praia mais carioca. Fica pro pôr do sol e aplaude.', 'lista'),
  ('s-arpoador', 'Arpoador', 'praia', 'Ipanema', 'Pedra com o pôr do sol mais famoso do Rio.', 'lista'),
  ('s-praia-do-leblon', 'Praia do Leblon', 'praia', 'Leblon', 'Mais tranquila que Ipanema, boa pra família e altinha.', 'lista'),
  ('s-praia-da-barra-da-tijuca', 'Praia da Barra da Tijuca', 'praia', 'Barra da Tijuca', 'Faixa enorme de areia, bom pra quem quer espaço.', 'lista'),
  ('s-prainha', 'Prainha', 'praia', 'Recreio', 'Praia de surfe cercada de mata, água mais limpa.', 'lista'),
  ('s-praia-de-grumari', 'Praia de Grumari', 'praia', 'Grumari', 'Selvagem, sem prédios. Leva comida, tem pouca estrutura.', 'lista'),
  ('s-praia-vermelha', 'Praia Vermelha', 'praia', 'Urca', 'Pequena, ao pé do Pão de Açúcar, água calma.', 'lista'),
  ('s-praia-do-recreio', 'Praia do Recreio', 'praia', 'Recreio', 'Tranquila, com a Pedra do Pontal no canto.', 'lista'),
  ('s-praia-da-joatinga', 'Praia da Joatinga', 'praia', 'Joá', 'Escondida entre pedras, acesso por trilha curta. Vai na maré baixa.', 'lista'),
  ('s-praia-do-leme', 'Praia do Leme', 'praia', 'Leme', 'Ponta de Copa, mais calma. Termina no Caminho dos Pescadores.', 'lista'),
  ('s-praia-de-sao-conrado', 'Praia de São Conrado', 'praia', 'São Conrado', 'Onde pousam as asas-deltas da Pedra Bonita.', 'lista'),
  ('s-praia-de-itacoatiara', 'Praia de Itacoatiara', 'praia', 'Niterói', 'Mar forte, paisagem linda, costão do Alto Mourão.', 'lista'),
  ('s-praia-do-abrico', 'Praia do Abricó', 'praia', 'Grumari', 'Praia de naturismo oficial do Rio.', 'lista'),
  ('s-praia-da-macumba', 'Praia da Macumba', 'praia', 'Recreio', 'Point de surfe e altinha.', 'lista'),
  ('s-pao-de-acucar-bondinho', 'Pão de Açúcar (bondinho)', 'mirante', 'Urca', 'Bondinho em duas etapas, vista da baía e de Copacabana.', 'lista'),
  ('s-trilha-do-morro-da-urca', 'Trilha do Morro da Urca', 'mirante', 'Urca', 'Sobe a pé até a primeira estação do bondinho, uns 40 min.', 'lista'),
  ('s-pista-claudio-coutinho', 'Pista Cláudio Coutinho', 'mirante', 'Urca', 'Caminhada plana na beira do mar, com micos e vista.', 'lista'),
  ('s-trilha-do-morro-dois-irmaos', 'Trilha do Morro Dois Irmãos', 'mirante', 'Vidigal', 'Sobe pelo Vidigal, uma hora de trilha, vista de toda a Zona Sul.', 'lista'),
  ('s-pedra-da-gavea', 'Pedra da Gávea', 'mirante', 'São Conrado', 'Trilha pesada com escalaminhada. Pra quem tá em forma.', 'lista'),
  ('s-pedra-bonita', 'Pedra Bonita', 'mirante', 'São Conrado', 'Trilha curta, vista da rampa de voo livre.', 'lista'),
  ('s-voo-de-asa-delta-ou-parapente', 'Voo de asa-delta ou parapente', 'mirante', 'São Conrado', 'Sai da Pedra Bonita e pousa na praia de São Conrado.', 'lista'),
  ('s-vista-chinesa', 'Vista Chinesa', 'mirante', 'Alto da Boa Vista', 'Mirante de pagode chinês dentro da Floresta da Tijuca.', 'lista'),
  ('s-mirante-dona-marta', 'Mirante Dona Marta', 'mirante', 'Botafogo', 'Vista do Cristo, Pão de Açúcar e Botafogo, de graça.', 'lista'),
  ('s-parque-nacional-da-tijuca', 'Parque Nacional da Tijuca', 'mirante', 'Alto da Boa Vista', 'Maior floresta urbana: cachoeiras, trilhas e o Pico da Tijuca.', 'lista'),
  ('s-pico-da-tijuca', 'Pico da Tijuca', 'mirante', 'Alto da Boa Vista', 'Ponto mais alto do parque, escadaria esculpida na pedra no final.', 'lista'),
  ('s-mirante-do-leblon', 'Mirante do Leblon', 'mirante', 'Leblon', 'No fim da praia, bom pra ver o pôr do sol com um chope.', 'lista'),
  ('s-parque-lage', 'Parque Lage', 'mirante', 'Jardim Botânico', 'Casarão com café, ponto de partida da trilha pro Cristo.', 'lista'),
  ('s-trilha-do-telegrafo', 'Trilha do Telégrafo', 'mirante', 'Barra de Guaratiba', 'Trilha curta até a pedra da foto famosa, na beira do abismo.', 'lista'),
  ('s-parque-da-cidade-de-niteroi', 'Parque da Cidade de Niterói', 'mirante', 'Niterói', 'Mirante com vista do Rio inteiro do outro lado da baía.', 'lista'),
  ('s-cristo-redentor', 'Cristo Redentor', 'postal', 'Corcovado', 'Sobe de trem do Cosme Velho ou de van. Vai cedo pra fugir da fila.', 'lista'),
  ('s-escadaria-selaron', 'Escadaria Selarón', 'postal', 'Lapa', 'Degraus cobertos de azulejos do mundo todo.', 'lista'),
  ('s-arcos-da-lapa', 'Arcos da Lapa', 'postal', 'Lapa', 'Aqueduto antigo, cartão-postal da Lapa.', 'lista'),
  ('s-bondinho-de-santa-teresa', 'Bondinho de Santa Teresa', 'postal', 'Santa Teresa', 'Bonde amarelo que sai do Centro e sobe pelo bairro.', 'lista'),
  ('s-maracana', 'Maracanã', 'postal', 'Maracanã', 'Pega um jogo ou faz o tour pelo estádio.', 'lista'),
  ('s-jardim-botanico', 'Jardim Botânico', 'postal', 'Jardim Botânico', 'Aleia das palmeiras imperiais, orquidário e muito verde.', 'lista'),
  ('s-lagoa-rodrigo-de-freitas', 'Lagoa Rodrigo de Freitas', 'postal', 'Lagoa', 'Volta de bike ou pedalinho, quiosques à noite.', 'lista'),
  ('s-boulevard-olimpico-e-praca-maua', 'Boulevard Olímpico e Praça Mauá', 'postal', 'Centro', 'Orla revitalizada, mural Etnias do Kobra.', 'lista'),
  ('s-confeitaria-colombo', 'Confeitaria Colombo', 'postal', 'Centro', 'Salão de 1894 com espelhos belgas. Pede um doce e um café.', 'lista'),
  ('s-real-gabinete-portugues-de-leitura', 'Real Gabinete Português de Leitura', 'postal', 'Centro', 'Biblioteca que parece cenário de filme. Entrada gratuita.', 'lista'),
  ('s-theatro-municipal', 'Theatro Municipal', 'postal', 'Centro', 'Tem visita guiada e espetáculos baratos.', 'lista'),
  ('s-ilha-fiscal', 'Ilha Fiscal', 'postal', 'Centro', 'Castelo verde na baía, passeio da Marinha.', 'lista'),
  ('s-museu-de-arte-contemporanea-mac', 'Museu de Arte Contemporânea (MAC)', 'postal', 'Niterói', 'O disco voador do Niemeyer com vista pro Rio.', 'lista'),
  ('s-feira-de-sao-cristovao', 'Feira de São Cristóvão', 'postal', 'São Cristóvão', 'Centro nordestino com forró, comida e cachaça.', 'lista'),
  ('s-museu-do-amanha', 'Museu do Amanhã', 'cultura', 'Centro', 'Museu de ciência do Calatrava na Praça Mauá.', 'lista'),
  ('s-museu-de-arte-do-rio-mar', 'Museu de Arte do Rio (MAR)', 'cultura', 'Centro', 'Arte e história do Rio, terraço com vista da baía.', 'lista'),
  ('s-aquario', 'AquaRio', 'cultura', 'Gamboa', 'Maior aquário marinho da América do Sul.', 'lista'),
  ('s-centro-cultural-banco-do-brasil-ccbb', 'Centro Cultural Banco do Brasil (CCBB)', 'cultura', 'Centro', 'Exposições boas e quase sempre de graça.', 'lista'),
  ('s-instituto-moreira-salles', 'Instituto Moreira Salles', 'cultura', 'Gávea', 'Casa modernista com jardim do Burle Marx e café.', 'lista'),
  ('s-museu-de-arte-moderna-mam', 'Museu de Arte Moderna (MAM)', 'cultura', 'Aterro do Flamengo', 'Prédio icônico, jardins do Burle Marx no Aterro.', 'lista'),
  ('s-museu-nacional-de-belas-artes', 'Museu Nacional de Belas Artes', 'cultura', 'Centro', 'Grande acervo de arte brasileira.', 'lista'),
  ('s-pequena-africa-e-cais-do-valongo', 'Pequena África e Cais do Valongo', 'cultura', 'Saúde', 'Tour pela história afro-brasileira do Rio.', 'lista'),
  ('s-parque-das-ruinas', 'Parque das Ruínas', 'cultura', 'Santa Teresa', 'Ruínas de casarão com mirante e eventos.', 'lista'),
  ('s-mosteiro-de-sao-bento', 'Mosteiro de São Bento', 'cultura', 'Centro', 'Igreja barroca toda em ouro. Missa com canto gregoriano no domingo.', 'lista'),
  ('s-museu-do-pontal', 'Museu do Pontal', 'cultura', 'Barra da Tijuca', 'Maior acervo de arte popular do país.', 'lista'),
  ('s-tour-na-rocinha-ou-no-vidigal', 'Tour na Rocinha ou no Vidigal', 'cultura', 'Zona Sul', 'Com guia local, vista absurda lá de cima.', 'lista'),
  ('s-bar-do-mineiro', 'Bar do Mineiro', 'boteco', 'Santa Teresa', 'Pastel de feijão e feijoada. Clássico de Santa.', 'lista'),
  ('s-jobi', 'Jobi', 'boteco', 'Leblon', 'Boteco tradicional aberto até tarde.', 'lista'),
  ('s-bracarense', 'Bracarense', 'boteco', 'Leblon', 'Chope gelado e bolinho de aipim com camarão.', 'lista'),
  ('s-bar-urca', 'Bar Urca', 'boteco', 'Urca', 'Cerveja na mureta vendo o pôr do sol na baía.', 'lista'),
  ('s-bar-luiz', 'Bar Luiz', 'boteco', 'Centro', 'Desde 1887, chope e salsichão.', 'lista'),
  ('s-bar-do-adao', 'Bar do Adão', 'boteco', 'Grajaú', 'Pastéis com dezenas de recheios.', 'lista'),
  ('s-botecos-da-praca-da-bandeira', 'Botecos da Praça da Bandeira', 'boteco', 'Praça da Bandeira', 'Point de boteco raiz, tipo Aconchego Carioca.', 'lista'),
  ('s-pavao-azul', 'Pavão Azul', 'boteco', 'Copacabana', 'Patanisca de bacalhau na calçada.', 'lista'),
  ('s-adega-perola', 'Adega Pérola', 'boteco', 'Copacabana', 'Balcão cheio de petiscos portugueses.', 'lista'),
  ('s-chico-alaide', 'Chico & Alaíde', 'boteco', 'Leblon', 'Boteco moderno com petiscos caprichados.', 'lista'),
  ('s-botecos-do-baixo-botafogo', 'Botecos do Baixo Botafogo', 'boteco', 'Botafogo', 'Rua Voluntários e arredores lotados à noite.', 'lista'),
  ('s-bar-da-gema', 'Bar da Gema', 'boteco', 'Tijuca', 'Coxinha famosa, boteco premiado.', 'lista'),
  ('s-churrascaria-fogo-de-chao', 'Churrascaria Fogo de Chão', 'comida', 'Botafogo', 'Rodízio com vista pro Pão de Açúcar.', 'lista'),
  ('s-biscoito-globo-e-mate-na-praia', 'Biscoito Globo e mate na praia', 'comida', 'Orla', 'Obrigatório. Compra do ambulante.', 'lista'),
  ('s-acai-na-orla', 'Açaí na orla', 'comida', 'Zona Sul', 'Açaí na tigela depois da praia.', 'lista'),
  ('s-feira-de-ipanema-praca-general-osorio', 'Feira de Ipanema (Praça General Osório)', 'comida', 'Ipanema', 'Feira hippie no domingo com acarajé.', 'lista'),
  ('s-confeitaria-kurt', 'Confeitaria Kurt', 'comida', 'Leblon', 'Tortas alemãs clássicas.', 'lista'),
  ('s-cervantes', 'Cervantes', 'comida', 'Copacabana', 'Sanduíche de pernil com abacaxi de madrugada.', 'lista'),
  ('s-galeto-sat-s', 'Galeto Sat''s', 'comida', 'Copacabana', 'Galeto e caipirinha no balcão, aberto até tarde.', 'lista'),
  ('s-casa-momus', 'Casa Momus', 'comida', 'Lapa', 'Comida mediterrânea no meio da Lapa.', 'lista'),
  ('s-cadeg-mercado-de-benfica', 'CADEG (Mercado de Benfica)', 'comida', 'Benfica', 'Almoço de sábado com bacalhau e muita gente.', 'lista'),
  ('s-lapa-a-noite', 'Lapa à noite', 'noite', 'Lapa', 'Rua lotada, bares e casas de samba. Fica esperto com o celular.', 'lista'),
  ('s-rio-scenarium', 'Rio Scenarium', 'noite', 'Lapa', 'Casarão de três andares cheio de antiguidades, samba e choro.', 'lista'),
  ('s-pedra-do-sal', 'Pedra do Sal', 'noite', 'Saúde', 'Roda de samba na rua, segunda e sexta.', 'lista'),
  ('s-samba-do-trabalhador-renascenca', 'Samba do Trabalhador (Renascença)', 'noite', 'Andaraí', 'Roda de segunda à tarde, muito tradicional.', 'lista'),
  ('s-ensaio-de-escola-de-samba', 'Ensaio de escola de samba', 'noite', 'Vários', 'Mangueira, Salgueiro, Portela. Ensaios de agosto a fevereiro.', 'lista'),
  ('s-baile-na-rocinha-ou-no-vidigal', 'Baile na Rocinha ou no Vidigal', 'noite', 'Zona Sul', 'Baile funk. Vai com quem conhece.', 'lista'),
  ('s-carioca-da-gema', 'Carioca da Gema', 'noite', 'Lapa', 'Samba ao vivo num sobrado.', 'lista'),
  ('s-baixo-gavea', 'Baixo Gávea', 'noite', 'Gávea', 'Praça lotada de gente bebendo na rua.', 'lista'),
  ('s-circo-voador', 'Circo Voador', 'noite', 'Lapa', 'Show de música debaixo da lona, programação variada.', 'lista'),
  ('s-blue-note-rio', 'Blue Note Rio', 'noite', 'Copacabana', 'Jazz com vista pra praia.', 'lista'),
  ('s-barca-para-niteroi', 'Barca para Niterói', 'passeio', 'Praça XV', 'Barca de 20 min com a melhor vista da baía.', 'lista'),
  ('s-passeio-de-barco-pela-baia', 'Passeio de barco pela Baía', 'passeio', 'Marina da Glória', 'Escuna passando pelo Pão de Açúcar e ilhas.', 'lista'),
  ('s-ilha-de-paqueta', 'Ilha de Paquetá', 'passeio', 'Baía de Guanabara', 'Ilha sem carro, de barca. Aluga bike e roda.', 'lista'),
  ('s-arraial-do-cabo', 'Arraial do Cabo', 'passeio', 'Região dos Lagos', 'Água azul-turquesa, passeio de barco. Bate-volta de 3h.', 'lista'),
  ('s-buzios', 'Búzios', 'passeio', 'Região dos Lagos', 'Praias e Rua das Pedras. Melhor com pernoite.', 'lista'),
  ('s-petropolis', 'Petrópolis', 'passeio', 'Serra', 'Museu Imperial e cervejarias. 1h de estrada.', 'lista'),
  ('s-ilha-grande', 'Ilha Grande', 'passeio', 'Angra dos Reis', 'Lopes Mendes e trilhas. Pede no mínimo 2 dias.', 'lista'),
  ('s-paraty', 'Paraty', 'passeio', 'Costa Verde', 'Centro histórico e passeio de barco. 4h de estrada.', 'lista'),
  ('s-pedalada-na-orla-bike-itau', 'Pedalada na orla (Bike Itaú)', 'passeio', 'Zona Sul', 'Bike alugada pelo app, do Leme ao Leblon.', 'lista'),
  ('s-domingo-na-orla-fechada', 'Domingo na orla fechada', 'passeio', 'Zona Sul', 'Pista da orla fechada pros carros aos domingos.', 'lista'),
  ('s-praia-do-pepe', 'Praia do Pepê', 'praia', 'Barra da Tijuca', 'Point da Barra, quiosques e kitesurf.', 'lista'),
  ('s-praia-de-piratininga', 'Praia de Piratininga', 'praia', 'Niterói', 'Lagoa e mar lado a lado, pôr do sol bonito.', 'lista'),
  ('s-praia-do-diabo', 'Praia do Diabo', 'praia', 'Arpoador', 'Prainha escondida entre o Arpoador e o Forte.', 'lista'),
  ('s-forte-de-copacabana', 'Forte de Copacabana', 'postal', 'Copacabana', 'Museu, vista da praia e café da Colombo no forte.', 'lista'),
  ('s-mureta-da-urca', 'Mureta da Urca', 'postal', 'Urca', 'Senta na mureta com cerveja e petisco vendo a baía.', 'lista'),
  ('s-sambodromo-marques-de-sapucai', 'Sambódromo (Marquês de Sapucaí)', 'postal', 'Centro', 'Dá pra visitar e conhecer a Cidade do Samba ali perto.', 'lista'),
  ('s-catedral-metropolitana', 'Catedral Metropolitana', 'postal', 'Centro', 'Catedral em forma de cone com vitrais gigantes.', 'lista'),
  ('s-parque-madureira', 'Parque Madureira', 'postal', 'Madureira', 'Parque grande da Zona Norte, com praia artificial.', 'lista'),
  ('s-trilha-da-pedra-do-pontal', 'Trilha da Pedra do Pontal', 'mirante', 'Recreio', 'Trilha curta com vista do Recreio e da Prainha.', 'lista'),
  ('s-caminho-dos-pescadores-e-forte-do-leme', 'Caminho dos Pescadores e Forte do Leme', 'mirante', 'Leme', 'Caminhada na pedra do Leme e trilha até o forte.', 'lista'),
  ('s-cachoeira-do-horto', 'Cachoeira do Horto', 'mirante', 'Jardim Botânico', 'Trilha fácil até poço de água gelada.', 'lista'),
  ('s-morro-da-babilonia', 'Morro da Babilônia', 'mirante', 'Leme', 'Trilha curta com vista de Copacabana.', 'lista'),
  ('s-pedra-do-telegrafo-com-praia-do-perigoso', 'Pedra do Telégrafo com Praia do Perigoso', 'mirante', 'Barra de Guaratiba', 'Combina a foto da Pedra com praias selvagens.', 'lista'),
  ('s-trilha-da-pedra-do-elefante-alto-mourao', 'Trilha da Pedra do Elefante (Alto Mourão)', 'mirante', 'Niterói', 'Vista de Itacoatiara e do Rio. Trilha pesada.', 'lista'),
  ('s-trilha-transcarioca-trecho-grumari', 'Trilha Transcarioca (trecho Grumari)', 'mirante', 'Grumari', 'Trecho da trilha que cruza a cidade, com mirantes das praias.', 'lista'),
  ('s-mirante-do-pasmado', 'Mirante do Pasmado', 'mirante', 'Botafogo', 'Vista da enseada de Botafogo e do Pão de Açúcar.', 'lista')
on conflict (id) do nothing;
