# Bora pro Rio

Site pra galera da viagem escolher onde ir no Rio: cada um marca **Quero ir** nos lugares que curte e pode adicionar lugares novos. Sem login: a pessoa só coloca o nome.

- `index.html`: o site (HTML/CSS/JS puro, sem build).
- `config.js`: URL e chave pública do Supabase.
- `supabase.sql`: cria as tabelas, as regras de acesso e os 113 lugares iniciais.
- `places-seed.json`: os mesmos lugares em JSON; o site coloca no banco sozinho os que faltarem.

## Colocar no ar (uma vez só)

1. **Supabase**: crie um projeto grátis em https://supabase.com. Abra **SQL Editor**, cole o conteúdo de `supabase.sql` e clique em **Run**.
2. Em **Project Settings → API**, copie a **Project URL** e a **anon public key** e cole em `config.js`.
3. **GitHub Pages**: repositório público, depois **Settings → Pages → Deploy from a branch → main / (root)**.
4. O site fica em `https://eduardoalkimim.github.io/Bora-pro-rio/`.

## Dados

- `places`: `id, name, category, area, note, link, added_by, added_by_name, created_at`
- `votes`: `place_id, voter_id, voter_name` (um voto por pessoa por lugar)

A identidade de cada pessoa é um id aleatório guardado no navegador dela. Os lugares da lista inicial não podem ser apagados pelo site; lugares adicionados só aparecem com "Remover" pra quem adicionou.

Categorias: `praia`, `mirante`, `postal`, `cultura`, `boteco`, `comida`, `noite`, `passeio`.
