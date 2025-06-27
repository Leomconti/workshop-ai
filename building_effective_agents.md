#llms #agents

# Anthropic guide

[Effective ai agents in 17 min](https://www.youtube.com/watch?v=WKUossf141M)

- talks well about technical parts, cambridge physics guy, smart.
- heavily linked to anthropic building effective agents, which is ok, but very shallow

## Augmented LLMs

- LLMs with tools, memory, other systems etc
- Basically more things than just the chat directly

## Workflows

### Prompt chaining

- Chains of augmented LLMs
- One after another, with retrieval, tools, memory...
- Why use different LLM calls in chain instead of doing everything in the same call?
  - Different models
  - Different instructions.. the more tasks you add to the LLM it will hallucinate more, perform worse and be more unpredictable. Where as if you split between different calls you have more predictable outputs that you can integrate into your system.
  - Also observability gets way easier when you can see and evaluate every step

### Routing

- Have LLM call router, that decides where to go to next
- For example you have 3 different paths to go with your agent, you will want a router that can understand the problem and give the request to the right LLM call.
- Example for a business support, have three options: Refund, Technical Questions, General Questions.
- You can also have a router for a router!
  - One router for technical questions, calls another router that decides what agent will answer that question better, by having specialized agents.

### Parallelization

- Query in, sends your request to multiple LLMs at the same time (parallel), and then you have some code that aggregates the results, and have an output.
- Or it's also possible you have an LLM at the end that aggregates and makes a different output for you, being it a report or anything you want.
-

###

# Building Effective Agents with Openai SDK

[Effective with openai sdk](https://www.youtube.com/watch?v=0OlP7x65YDw)

- seems like a good technical guy, channel does paper walkthroughs etc.
- has a document structured with info about it, so called webinar

[Vp of openai on building ai agents](https://www.youtube.com/watch?v=joHR2pmxDQE)

- 16 min video on that

## From DeeplearningAI Agents concepts

https://www.deeplearning.ai/the-batch/how-agents-can-improve-llm-performance/

## Ai agents architectures

![[imgs/architectures.png]]

# Building agents with structured outputs and reasoning LLMs

https://www.promptingguide.ai/guides/reasoning-llms?utm_source=alphasignal
