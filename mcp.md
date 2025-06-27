Best explanation I've seen on MCP is by OpenAI agents
https://openai.github.io/openai-agents-python/mcp/
Their examples
https://github.com/openai/openai-agents-python/tree/main/examples/mcp

**MCP is literally a place to find tools and call them. It's just tool calling**

Basically if someone made a very good api with documentation on how to use it, all parameters, all inputs, all outputs, all you need to do is call it.

MCP is a way to make that happen. Not anythign special, you can call directly in code to fetch the tools and call them yourself, but, appeal is that it's good for LLMs as the MCP server can be updated and the LLM understand the new tools, or different parameters straight away.
