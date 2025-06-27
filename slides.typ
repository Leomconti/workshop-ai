#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/numbly:0.1.0": numbly

#show: simple-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [LLM, Agentes, Workflows],
    subtitle: [Construindo Aplicações com LLMs],
    author: [Leonardo Mosimann Conti],
    date: [17/06/2025 02:16],
  ),
)

#set text(font: "Roboto")

// -----------------------------------------------------------------------------
// 0. Capa
= Construindo Aplicações com LLMs
*Workshop Evoluum*

- Não é tutorial · dicas reais
- Mão na massa · interativo
- Sem bullshit 🎉

// -----------------------------------------------------------------------------
// 1. Roteiro
== O que veremos hoje

- Agentes de IA? O que é o Hype? 🤖
- Fundamentos do Prompt: A base de tudo ✍🏻
- A "Mágica" dos Agentes: Structured Outputs ✨
- Contexto é Rei: Controle a Janela de Contexto 👑
- Workflows > Agentes: Comece Simples 🍃
- MCP: Catálogo de Ferramentas 🪛
- Codando com Cursor 😮
- Construção ao Vivo & Perguntas 🤓☝🏻

// -----------------------------------------------------------------------------
// 2. Quebra-gelo
== O que é um *AI Agent*?

"Compartilhe: Já usou um LLM? Onde?"
#speaker-note[
  Anota as respostas pra voltar depois. Bota um clima leve, zoeira na medida!
]

// -----------------------------------------------------------------------------
// 3. Fundamentos do Prompt
== Fundamentos de *Prompting* - Zero/One/Few-Shot

- Zero-shot: Só descreve, sem exemplo
  ```txt
  Classifique como positivo ou negativo.
  ```
- One/few-shot: Exemplos guiam o padrão
  ```json
  // Few-shot pra classificar sentimento
  {"input":"Dia incrível!","output":"positivo"}
  {"input":"Que droga!","output":"negativo"}
  ```

// -----------------------------------------------------------------------------
// 4. Fundamentos do Prompt
== Exemplos Few-Shot: Bom ou Ruim?

#text(size: 17pt)[
1: (Ruim - Pouca diversidade)
```json
{"input":"Quero falar com o suporte agora!","intent":"suporte"}
{"input":"Preciso de ajuda técnica urgente!","intent":"suporte"}
{"input":"Alguém do suporte pode me atender?","intent":"suporte"}
{"input":"Gostaria de adquirir a versão Pro.","intent":"vendas"}
```
2: (Bom - Casos variados)
```json
{"input":"Meu app trava no login.","intent":"suporte"}
{"input":"Não consigo enviar e-mails.","intent":"suporte"}
{"input":"Quero o plano Premium hoje.","intent":"vendas"}
{"input":"Como é o licenciamento?","intent":"vendas"}
{"input":"O sistema não carrega configs.","intent":"suporte"}
```
]
#speaker-note[
  Explica: "Exemplo 2 é melhor por cobrir mais casos. Qual vocês fariam?"
]

// -----------------------------------------------------------------------------
// 5. Fundamentos do Prompt
== Fundamentos de *Prompting* - System/Context/Role

- System/context/role: Define quem o LLM é
- Exemplo:
  ```txt
  // System prompt pra guia turístico
  System: Você é um guia turístico engraçado.
  Context: Sugira 3 lugares no Rio.
  ```
#speaker-note[
  Fala que é dar "personalidade" pro LLM. Pede ideias de papéis.
]

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// 6. Fundamentos do Prompt
== Fundamentos de Prompting - Chain of Thought

Chain of Thought (CoT): Raciocínio passo a passo

Exemplo de verdade (prioridade & escalonamento de ticket):

#text(size: 17pt)[
```txt
Critérios:
  • Plano       → Free (72 h) · Pro (48 h) · Enterprise (24 h)
  • Severidade  → blocker > major > minor
  • Regras      → Se violou SLA ou é blocker ⇒ escalar

Solicitação:
  Ticket #8421 (cliente Enterprise) aberto há 30 h.
   Usuário relata: 'Não consigo finalizar pagamentos, tudo falha!'
   ```
]

// -----------------------------------------------------------------------------
// 7. Fundamentos do Prompt chain of thought
== Exemplo de Chain of Thought
Prompt

#text(size: 17pt)[```txt
Decida se deve escalar para Engenharia.Pense passo a passo e depois responda apenas JSON{ "escalar": true/false, "motivo": "<texto curto>" }
```
]

Raciocínio esperado:

#text(size: 17pt)[```txt
1) Plano = Enterprise ⇒ SLA 24 h
2) Tempo aberto = 30 h ⇒ violou SLA
3) Severidade = blocker (pagamentos indisponíveis)
4) Qualquer critério já bastaria; temos ambos

Resposta: {"escalar": true, "motivo": "SLA violado e blocker"}
```
]

#speaker-note[
Mostre a cadeia: plano → SLA → severidade → decisão.Brinque: “Isso não cabe num simples if tempo > SLA. Aqui o LLM vira chefe de plantão!”
]

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 8. Fundamentos do Prompt - structure doutputs
== Fundamentos de Prompting - Structured Output
JSON para structured output
- e.g. Geração de histórias de usuário a partir de transcript de call):

#text(size: 14pt)[```txt
Prompt (resumido):
Você é Product Owner sênior. Abaixo segue o transcript da reunião de discovery <transcript>.
Gere até 5 histórias de usuário priorizadas em formato JSON:
[{ "ator": <string>, "acao": <string>, "valor": <string>, "sla_horas": <int> }].
Priorize pelo impacto mencionado na call.
Primeiro pense passo a passo e destaque a motivacao de suas escolhas na chave justificativa.

Retorne estritamente:
{
  "justificativa": "<passo a passo curto>"
  "historias": [...],
}
```
]

Resposta esperada (exemplo):

#text(size: 14pt)[```json
{
  "historias": [
    { "ator": "Comprador", "acao": "finalizar pagamento com 1 clique", "valor": "reduzir abandono", "sla_horas": 120 },
    { "ator": "Admin", "acao": "gerar relatório de vendas diário", "valor": "tomar decisões rápidas", "sla_horas": 72 }
  ],
  "justificativa": "Pagamentos e visibilidade de vendas foram tópicos mais críticos na call."
}
```
]

Dica: Use justificativa como CoT, um campo str aberto para o LLM, e no backend você parseia somente historias. Nem sempre necessario, mas pode ajudar em tarefas mais complexas.

#speaker-note[
Demonstre que o LLM assume o papel de PO júnior - extrai atores, ações e prazos direto do Zoom! 😎
]

// -----------------------------------------------------------------------------
// 10. Fundamentos do Prompt
== Fundamentos de *Prompting* - Parâmetros

- Parâmetros: *Temperature*, *Top-K*, *Top-P*
- Exemplo:
  ```plaintext
  // Upsell criativo
  {"temperature":0.9,"top_p":0.9}
  // Contrato jurídico
  {"temperature":0.2,"top_p":0.5}
  ```
#speaker-note[
  Explica: "É o botão de loucura do LLM. Mais ou menos criativo?"
]

// -----------------------------------------------------------------------------
// 11. A "Mágica" dos Agentes
== *Structured Outputs* ✨

- Segredo dos agentes: Saídas estruturadas
- Nada de texto solto: use JSON pro código entender
- *Tool calling*? Só um *structured output* chique
- Exemplo (DevOps):
  ```json
  {
    "name":"list_git_tags",
    "arguments":{"repo":"backend-api"}
  }
  ```
#speaker-note[
  Diz: "Isso é o LLM virando amigo do seu pipeline CI/CD!"
]

// -----------------------------------------------------------------------------
// 12. Contexto é Rei
== Controle a Janela de Contexto 👑

- LLMs são *stateless*: Sem memória
- Contexto é TUDO que o LLM vê
- Engenharia de contexto tao importante quanto engenharia de prompt
- Exemplo padrão (OpenAI):


#text(size: 17pt)[```json
  [
    {"role":"user","content":"Deploy o backend"},
    {"role":"assistant","tool_calls":[
       {"id":"1","name":"list_git_tags"}
    ]}
  ]
  ```
]

#speaker-note[
  Fala: "Sem contexto, eh querer que ele adivinhe, que nem pegar uma task no meio do caminho sem documentacao"
]

// -----------------------------------------------------------------------------
// 13. Contexto é Rei
== Contexto Rico: Faça do Seu Jeito

- Contexto otimizado:

#text(size: 17pt)[```txt
  <slack_message from="@alex" channel="#deployments">
    Deploy o backend?
  </slack_message>
  <tool_executed name="list_git_tags">
    <result><tags><tag>v1.2.3</tag></tags></result>
  </tool_executed>
  Próximo passo?
  ```
]

- Você decide como o LLM "enxerga" o contexto, use ao seu favor

// -----------------------------------------------------------------------------
// 14. Mini-Demo #1
== Chamada de API Básica

#text(size: 17pt)[```python
from openai import OpenAI
client = OpenAI(api_key="...")
messages = [
  {"role":"system","content":"Você é analista de CX."},
  {"role":"user",
   "content":"Um ticket aberto há 5 dias tem SLA de 3 dias. Está violado? Responda Sim/Não."}
]
response = client.chat.completions.create(
  model="gpt-4o-mini",
  messages=messages
)
print(response.choices[0].message.content)
```
]
#speaker-note[
  Roda ao vivo: "Olha o LLM cuspindo magia – sem 5+3!"
]

// -----------------------------------------------------------------------------
// 15. Abstração da API
== Chamada Estruturada (Python)

#text(size: 17pt)[
```python
async def call_structured[T: BaseModel](
    self, model: str, system_prompt: str,
    user_prompt: str, output_model: type[T]
) -> T:
    response = await self.client.beta.chat.completions.parse(
        model=model,
        messages=[
          {"role":"system","content":system_prompt},
          {"role":"user","content":user_prompt}
        ],
        response_format=output_model,
    )
    if parsed := response.choices[0].message.parsed:
        return parsed
    raise ValueError("No JSON? Algo deu ruim!")
```
]
#speaker-note[
  "Isso faz o LLM devolver JSON limpinho – pronto pra frete, finanças, o que for."
]

// -----------------------------------------------------------------------------
// 16. Abstração da API
== Chamada Estruturada (Typescript)

#text(size: 17pt)[
```typescript
export async function callStructured<T>(
  model: string,
  systemPrompt: string,
  userPrompt: string,
  schema: ZodType<T>
): Promise<T> {
  const response = await openai.responses.parse({
    model,
    input: [
      { role: "system", content: systemPrompt },
      { role: "user", content: userPrompt },
    ],
    text: { format: zodTextFormat(schema, "response") },
  });
  if (!response.output_parsed)
    throw new Error("Sem JSON! Dá um log aqui.");
  return response.output_parsed;
}
```
]
#speaker-note[
  "Mesma ideia, mas pro time de TypeScript. 😉"
]

// -----------------------------------------------------------------------------
// 17. Workflows > Agentes
== Comece Simples, Mantenha o Controle 🍃

- *Workflow*: Fluxo previsível, você manda
- *Agent*: LLM escolhe o próximo passo
- Dica: Workflow primeiro, agente só se precisar
- Faz funcionar antes de dar liberdade
#speaker-note[
  Mostra um workflow de triagem de tíquetes. Pergunta: "Liberdade ou controle?"
]

// -----------------------------------------------------------------------------
// 18. Visão do MCP
== *MCP*: Catálogo de Ferramentas 🪛

- Descobre e chama ferramentas
- Integra com workflows ou agents
- Demo: Lista ferramentas → chama uma
#speaker-note[
  Mostra uma chamada no MCP: "É um cardápio de APIs, só escolher!"
]

// -----------------------------------------------------------------------------
// 19. Lições Práticas
== Dicas de Projetos Reais

- Controle o *context window*
- Ferramentas = *structured outputs*
- *Human-in-loop* pra não dar ruim
- Modelos menores + router > modelo grandão
#speaker-note[
  Conta a história do deploy 3 AM que o agente quase quebrou (gargalhada garantida).
]

// -----------------------------------------------------------------------------
// 20. Codando com IA
== Codificando com *Cursor* 😮

- Chat inline, abas de agentes, regras
- *Trust-but-verify*: Revisar é rei
- Demo: Cursor na prática
#speaker-note[
  "Até minha vó revisaria PR com isso!"
]

// -----------------------------------------------------------------------------
// 21. Brainstorm em Grupo
== Ideias pra Agentes

- *Que problema você quer resolver com um agent?*
- Discussão: 10 minutos
- Escolhemos uma ideia juntos
#speaker-note[
  Facilita com energia. Pega uma ideia prática pro build.
]

// -----------------------------------------------------------------------------
// 22. Construção ao Vivo
== Mão na Massa: Agente Simples 🫨

`Python/Typescript + OpenAI SDK`

- Código inicial no chat
- Eu codifico, vocês sugerem ajustes
- 30 minutos colaborativos
#speaker-note[
  Usa ferramenta + JSON. Puxa o público pra brincar.
]

// -----------------------------------------------------------------------------
// 23. Encerramento
== Principais Aprendizados

- Contexto é rei
- Workflows primeiro, agents depois
- MCP é seu catálogo de ferramentas
- Cursor turbina seu código
- *Desafio*: o que você vai testar?
- Como eu posso ajudar a tirar todas as duvias para comecarmos a aplicar?
#speaker-note[
  Fecha com gás. Pede algo concreto pra levarem.
]

// -----------------------------------------------------------------------------
// 24. Perguntas
== Suas Dúvidas 🤓☝🏻

#speaker-note[
  Responde tudo. Liga com o quebra-gelo.
]

// -----------------------------------------------------------------------------
// 25. Recursos
== Pra Aprofundar

- Anthropic Workflows Cookbook
- OpenAI Agents SDK
- 12-Factor Agents by HumanLayer
- Documentação do Cursor
- Prompt Lib Business: https://x.com/ridbay/status/1931405358519435766
- ChatGPT Natural Prompt: https://x.com/markgadala/status/1930637344790421785
