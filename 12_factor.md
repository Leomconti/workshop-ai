https://github.com/humanlayer/12-factor-agents

Best concepts so far:
[Natural language to tool calls](https://github.com/humanlayer/12-factor-agents/blob/main/content/factor-01-natural-language-to-tool-calls.md)

- absolutely like this, LLMs provide a "simple" way to make natural language user input into something your code knows.
  [Tools are just structured output](https://github.com/humanlayer/12-factor-agents/blob/main/content/factor-04-tools-are-structured-outputs.md)
- tools are what they defined as a way to communicate with your code, but with structured outputs you can do just that, with more granularity and control, you give the LLM a way to communicate with your code's possible flows/actions (structured outputs) and you can decide what you want to do with it
  [Own your context window](https://github.com/humanlayer/12-factor-agents/blob/main/content/factor-03-own-your-context-window.md)
- you can write context however you want, you don't need to adhere to single user/assistant/tool structure, use frameworks that format it for you.. you can simply do things, as LLMs are stateless apis – and they do not remember what happened from one call to the other – it gives us the opportunity to at every step optimize for the best output, like formulating a bit differently how we manage the information from a tool call into a better instruction for the LLM
  [Own your control flow](https://github.com/humanlayer/12-factor-agents/blob/main/content/factor-08-own-your-control-flow.md)
- Build your own control structures that make sense for your specific use case. Some calls may be the reason to leave the loop, to go to a totally different path; Maybe you want to add intermediate steps through other agents that are not related to that tool call, maybe an LLM as judge in the middle, other specific things... For that, you have to own your control flow.
