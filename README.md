# Bora pro Rio

Lista compartilhada de lugares no Rio de Janeiro pra galera da viagem votar ("Quero ir") e sugerir lugares novos.

- **Site no ar:** https://claude.ai/artifact/P14xkSQGQ1KXTRBiEgNkSg (Artifact do claude.ai)
- `index.html`: a página. Usa o banco compartilhado do Artifact (`claude.use("db")`) e a identidade do visitante (`claude.use("user")`).
- `places-seed.json`: os 97 lugares iniciais carregados no banco.

## Dados

- `places/{id}`: `{ name, category, area, note, link, addedBy, createdAt }`
- `votes/{userId}`: `{ places: { [placeId]: true }, updatedAt }`. Cada pessoa só escreve o próprio documento de votos.

Categorias: `praia`, `mirante`, `postal`, `cultura`, `boteco`, `comida`, `noite`, `passeio`.
