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
// #set heading(numbering: numbly("{1}.", default: "1.1"))

// -----------------------------------------------------------------------------
// 0. Capa
= Construindo Aplicações com LLMs
*Workshop Evoluum*

- Não é tutorial · dicas reais
- Mão na massa · interativo
- Sem bullshit 🎉
#speaker-note[
  Começa com gás! Pede pra galera se meter e interromper.
]

// -----------------------------------------------------------------------------
// 1. Roteiro
== O que veremos hoje

#text(size: 22pt)[
- Agentes de IA: Hype ou real? 🤖
- Agentes autônomos vs. Workflows 🍃
- Contexto é rei 👑
- Structured Outputs: A mágica ✨
- MCP: Catálogo de ferramentas 🪛
- Dicas e boas práticas 🛠️
- Engenharia de Prompt ✍🏻
- Codando com Cursor 😮
- Mão na massa & Perguntas 🤓☝🏻
]
#speaker-note[
  Explica: Foco em conceitos, não código. "Vocês já são feras no código!"
]

// -----------------------------------------------------------------------------
// 2. Quebra-gelo
== O que é um *AI Agent*?

- Quem já usou LLMs? Como?
- Por que usou? Motivo específico?
- O que é um "agente" pra você?
- Quando que eh agente e quando nao eh?

#speaker-note[
  Anota respostas. Cria clima leve: "Sem pressão, só papo!"
]

// -----------------------------------------------------------------------------
// 3. Agentes de IA
== Hype vs. Realidade 🤖

- Agentes: LLMs em sistemas de decisão, fazem algo com a resposta alem do texto
- Muitos "agentes" = máquinas de estado que chamam LLMs
- Não são (sempre) autônomos
#speaker-note[
  Metáfora: "É um assistente, mas sem café." Pede opiniões do público.
]

// -----------------------------------------------------------------------------
// 4. Agentes Autônomos
== Agentes Autônomos: Cuidado!

- Pouco controle: Loops abertos, custos altos
- Ex.: Deep research com busca e sumarização
- Risco: Pode rodar pra sempre! 😱
#speaker-note[
  Zoeira: "Imagina a conta da API!" Fala dos perigos.
]

// -----------------------------------------------------------------------------
// 5. Workflows
== Workflows: Simplicidade 🍃

- Fluxos restritos, previsíveis
- Ex.: Transcrição → insights → tasks no Trello
- Minha escolha: Comece simples e bem definido
#speaker-note[
  Mostra o Trello. Pergunta: "Que fluxo você criaria?"
]

// -----------------------------------------------------------------------------
// 6. Modelos de Workflows
= Construindo Agentes e Workflows

== Prompt Chaining

- Encadeamento: Prompt leva ao próximo
- If/else usa outputs anteriores
- Ex.: Classificar → processar → salvar
#speaker-note[
  Explica: "É uma linha de produção!" Pede exemplos.
]

// -----------------------------------------------------------------------------
// 7. Modelos de Workflows
== Routing

- LLM classifica input e redireciona
- Ex.: Suporte → refund, tech, geral
- Roteia pra workflow ou código
#speaker-note[
  Fala: "É um porteiro esperto!" Pede ideias de roteamento.
]

// -----------------------------------------------------------------------------
// 8. Modelos de Workflows
== Parallelization

- Chamadas paralelas, sintetiza resultados
- LLM pode resumir/juntar outputs
- Reduz latência
#speaker-note[
  Diz: "Tudo de uma vez!" Explica síntese com LLM.
]

// -----------------------------------------------------------------------------
// 9. Modelos de Workflows
== Orchestrator-Workers

- Código define fluxo e execução
- Gerencia paralelo, junta resultados
- Controle total
#speaker-note[
  Metáfora: "Você é o maestro!" Compara com microserviços.
]

// -----------------------------------------------------------------------------
// 10. Modelos de Workflows
== Evaluator-Optimizer

- Gera → avalia → ajusta em loop
- Ex.: Gera texto, avalia qualidade
- Refina resultados
#speaker-note[
  Fala: "É um editor chato revisando tudo!"
]

// -----------------------------------------------------------------------------
// 11. Agentes Autônomos
== Implementação de Agentes Autonomos

- Loop: Chamada → ferramenta → volta
- Ex.: Problemas abertos, como engenharia
- Foco: Simplicidade e transparência
#speaker-note[
  Reforça: "Use só se precisar. Loga tudo!"
]

// -----------------------------------------------------------------------------
= Modelos mentais para construcao de agentes

// 12. Engenharia de Contexto
== Contexto é Rei 👑

- LLMs são *stateless*: Contexto é tudo
- Engenharia de contexto > prompt (na real, complementares)
- Molde pra máxima eficiência
- Os melhores outputs vem dos melhores inputs
#speaker-note[
  Fala: "Sem contexto, é pedir pizza sem sabor!"
]

// -----------------------------------------------------------------------------
// 13. Contexto Padrão
== Contexto Padrão (OpenAI)

```json
[{"role": "user", "content": "Deploy o backend"},
 {"role": "assistant", "tool_calls": [{"id": "1", "name": "list_git_tags"}]}]
```
- Funciona 👍🏻 Porem... Nos temos o controle, porque nao melhoramos?
#speaker-note[
  Mostra: "É básico, mas meio bagunçado."
]

// -----------------------------------------------------------------------------
// 14. Contexto Otimizado
== Contexto Rico: Faça do Seu Jeito

```plaintext
Tudo que rolou:
<slack_message from="@alex">
  Deploy o backend?
</slack_message>
<tool_executed name="list_git_tags">
  <result><tags><tag>v1.2.3</tag></tags></result>
</tool_executed>
Próximo passo?
```
- Controle total da instrucao passada para LLM
#speaker-note[
  Diz: "É um e-mail pro chefe pro LLM!"
]

// -----------------------------------------------------------------------------
// 15. Structured Outputs
== A Mágica dos Agentes ✨

- Ferramentas = *structured outputs* (JSON)
- *Tool calling* = JSON formatado
- Controle e integração com código
#speaker-note[
  Fala: "LLM vira amigo do seu código!"
]

// -----------------------------------------------------------------------------
// 16. Natural Language to Tool Call
== Superpoder: Natural Language → JSON

```json
// Input: "Crie link de $750 pra Terri pelo meetup"
{
  "function": {
    "name": "create_payment_link",
    "parameters": {
      "amount": 750,
      "customer": "cust_128934ddasf9",
      "memo": "Patrocínio meetup de IA"
    }
  }
}
```
#speaker-note[
  Mostra: "De texto solto pra API num piscar!"
]

// 16. Natural Language to Tool Call
== Voce eh dono do seu control flow
- Projetos com LLM ainda sao projetos de software
- Logging, error handling, tudo!
- Nao tercerize tudo, nao confie em tudo.
- Tenha controle sobre o que esta acontecendo, se precisar parar, entender onde quebrou etc, ou ate adicionar flows com human in the loop, com dependencia de webhooks, triggers etc.

#speaker-note[
  Mostra: "De texto solto pra API num piscar!"
]
// -----------------------------------------------------------------------------
// 17. MCP
== *MCP*: Catálogo de Ferramentas 🪛

- Registro de ferramentas, "USB-C" de APIs
- LLM usa *list_tools* pra entender/chamar
- Hype exagerado, mas útil
#speaker-note[
  Zoeira: "MCP fez APIs decentes virarem moda!"
]

// -----------------------------------------------------------------------------
// 18. MCP: Exemplo
== Demo do MCP

- Listar ferramentas → chamar uma
- Ex.: Adicionar task no Trello
- Padroniza, LLM adapta
#speaker-note[
  Mostra: "É um cardápio de APIs!"
]

// -----------------------------------------------------------------------------
// 19. Dicas e Boas Práticas
= Dicas de Projetos Reais
== DEVO FAZER FT? NAO.

- Evite fine-tuning: Use modelos fundacionais
- infra, problemas, custo, tempo, etc.

// 19. Dicas e Boas Práticas
== Qual modelo uso??

- OpenRouter pra testar tudo, prod tb
- Valide com modelo grande, otimize depois

// 19. Dicas e Boas Práticas
== FRAMEWORKS???

- Evite LangChain-like frameworks
- Prefira Vercel AI-SDK - Abstracoes boas! (por enquanto...)
- OpenAI api is all you need :)

// -----------------------------------------------------------------------------
// 20. Mais Dicas
== Boas Práticas

- Tracing: Arize Phoenix, Wandb com spans
- Contexto reutilizável nos fluxos
- *Human-in-loop* pra segurança - depende da aplicacao
- Controle o fluxo: Logs, erros
#speaker-note[
  Fala: "Tracing é seu raio-X do agente!"
]

// -----------------------------------------------------------------------------
// 21. Engenharia de Prompt
== Speedrun de Prompts ✍🏻

- Qualquer um faz prompts!
- Defina IN > OUT claramente
- Envolva especialistas pra edge cases
#speaker-note[
  Diz: "Prompt é testar até acertar!"
]

// -----------------------------------------------------------------------------
// 22. Prompt: Zero-shot
== Zero-shot

- Tarefa sem exemplos
- Exemplo: "Classifique como positivo ou negativo."
#speaker-note[
  Explica: "Rápido, mas pode ser vago."
]

// -----------------------------------------------------------------------------
// 23. Prompt: One/Few-shot
== One/Few-shot

- Exemplos guiam o padrão
- Exemplo:
  ```json
  // Few-shot pra classificar sentimentos
  {"input": "Dia incrível!", "output": "positivo"}
  {"input": "Que droga!", "output": "negativo"}
  ```
#speaker-note[
  Fala: "É mostrar o caminho pro LLM!"
]

// -----------------------------------------------------------------------------
// 24. Prompt: System/Context/Role
== System/Context/Role

- Define comportamento e persona
- Exemplo:
  ```plaintext
  // System prompt pra guia turístico
  System: Você é um guia turístico engraçado.
  Context: Sugira 3 lugares no Rio.
  ```
#speaker-note[
  Diz: "Dá personalidade pro LLM!"
]

// -----------------------------------------------------------------------------
// 25. Prompt: Chain of Thought
== Chain of Thought (CoT)

- Raciocínio passo a passo
- Exemplo:
  ```plaintext
  // CoT pra somar 5 + 3
  "Vamos passo a passo: 5 + 3 = 8"
  ```
#speaker-note[
  Zoeira: "É ensinar matemática pro primo!"
]

// -----------------------------------------------------------------------------
// 26. Prompt: Structured Output
== Structured Output

- JSON pra consistência
- Exemplo:
  ```json
  // Saída estruturada
  {"task": "sum", "result": 8}
  ```
#speaker-note[
  Fala: "JSON é o idioma do código!"
]

// -----------------------------------------------------------------------------
// 27. Prompt: Parâmetros
== Parâmetros

- *Temperature*, *Top-K*, *Top-P*
- Exemplo:
  ```plaintext
  // Ajuste de criatividade
  {"temperature": 0.7, "top_p": 0.9} // Mais variado
  ```
#speaker-note[
  Fala: "É o botão de loucura do LLM!"
]

// -----------------------------------------------------------------------------
// 28. Prompt: Step-Back
== Step-Back Prompting

- Gera contexto antes do prompt final
- Ex.: Peça ideias pra refinar o prompt
- Melhora precisão em tarefas complexas
#speaker-note[
  Explica: "É como planejar antes de agir."
]

// -----------------------------------------------------------------------------
// 29. Prompt: Self-Consistency
== Self-Consistency

- Múltiplas respostas CoT, escolhe a melhor
- Filtra erros, aumenta robustez
- Custa mais tokens/tempo
#speaker-note[
  Fala: "É votar pra decidir a resposta certa!"
]

// -----------------------------------------------------------------------------
// 30. Codando com Cursor
== Codificando com *Cursor* 😮

- Chat inline, abas de agentes, regras
- *Trust-but-verify*: Revisar é rei
- Demo: Cursor num projeto pequeno
#speaker-note[
  Mostra: "Até minha vó usaria isso!"
]

// -----------------------------------------------------------------------------
// 31. Mini-Demo: API
== Chamada de API Básica

```python
from openai import OpenAI
client = OpenAI(api_key="...")
response = client.chat.completions.create(model="gpt-4o", messages=[...])
```
#speaker-note[
  Roda ao vivo: "Olha o LLM cuspindo magia!"
]

// -----------------------------------------------------------------------------
// 32. Construção ao Vivo
== Mão na Massa: Agente Simples 🫨

`Python/Typescript + OpenAI SDK`

- Ex.: Transcrição → tasks no Trello
- Código inicial no chat
- 30 minutos colaborativos
#speaker-note[
  Puxa o público: "Sugiram ajustes, se metem!"
]

// -----------------------------------------------------------------------------
// 33. Encerramento
== Principais Aprendizados

- Contexto é rei
- Workflows primeiro, agents depois
- MCP simplifica ferramentas
- Cursor turbina código
- "O que você vai testar amanhã?"
#speaker-note[
  Fecha com energia. Pede algo prático.
]

// -----------------------------------------------------------------------------
// 34. Perguntas
== Suas Dúvidas 🤓☝🏻

#speaker-note[
  Responde tudo. Liga com o quebra-gelo.
]

// -----------------------------------------------------------------------------
// 35. Recursos
== Pra Aprofundar

- Anthropic Workflows Cookbook
- OpenAI Agents SDK
- 12-Factor Agents by HumanLayer
- Documentação do Cursor
- Prompt Lib Business: https://x.com/ridbay/status/1931405358519435766
- ChatGPT Natural Prompt: https://x.com/markgadala/status/1930637344790421785
#speaker-note[
  Destaca: "Cookbooks são ouro pra começar!"
]

// -----------------------------------------------------------------------------
// 36. Roadmap de Aprendizado
== Roadmap de Aprendizado

#text(size: 17pt)[
  - Tracing básico
- Structured Outputs
- Multi-LLM Wrapper, faz um falar com o outro nao sei, da uma personalidde para cada, testa – trocar `model` (GPT-4o / Claude / Llama)
- MCP Tools – `list_tools` + 1 mcp real
- Workflows – tente fazer um codigo onde a partir do input do usuario voce salva algumas ifnos no contexto ( do codigo ) tipo o id do usuario nome etc, input .. dai passa por algum building block
]

== Roadmap de Aprendizado
#text(size: 17pt)[
- Workflow que faz algo – transcrição → tarefas Trello; passos fixos, sem loop aberto, -> transcricoa -> planejamento sla estruturacao -> criacao das tarefas ( ou usar MCP/ferramenta, ou JSOn mode, ou os dois, faz os JSON dps manda pra usar o MCP, ou, simplesmente use o MCP :))
- Eval Harness – 5-10 testes gold; CLI de regressão e comparação de modelos
- Guardrails & Custos – budget de tokens, tente fazer rodar agora com modelos menores, o que voce vai fazer? decompor a tarefa?
]
