### Everyone reaches for agents first... Is it right?

[agents high growth engineer](https://read.highgrowthengineer.com/p/stop-building-ai-agents-heres-what-to-do-instead?utm_source=substack&publication_id=1504485&post_id=163856589&utm_medium=email&utm_content=share&utm_campaign=email-share&triggerShare=true&isFreemail=true&r=2tbz0a&triedRedirect=true)

![[imgs/workflow1.png]]

> Everyone thinks agents are where you start. It’s not their fault: frameworks make it seem easy, demo videos are exciting, and tech Twitter loves the hype.

**most agent systems break down from too much complexity, not too little.**

### What makes an agent?

So wait: what exactly is an agent? To answer that, we need to examine 4 characteristics of LLM systems.

1. **Memory:** Let the LLM remember past interactions
2. **Information Retrieval:** Add RAG for context
3. **Tool Usage:** Give the LLM access to functions and APIs
4. **Workflow Control:** The LLM output controls which tools are used and when
   ^ THIS makes an **agent**

> When people say “agent,” they mean that last step: the LLM output controls the workflow. Most people skip straight to letting the LLM control the workflow without realizing that **simpler patterns often work better**.

Simpler!! Exactly, the LLM doesn't need to freely choose the next steps most of the time, simpler and more constrained environments will work better.

> But unless your task is so dynamic that its flow can’t be defined upfront, that kind of freedom usually hurts more than it helps.

**Takeaway:** Start with simpler workflows like chaining or routing unless you know you need **all** the characteristics we listed.

What I want to pass you is:

As you can see, most use cases don’t need agents. They need a better workflow structure. The cases that do need agents often have unstable workflows that can’t be well-defined upfront.
Only use "agents" (fully autonomous) if you really have to!!

Where actual autonomous agents can shine is exploratory things, for example, when you give tools and want it to use them truly freely however they want. An example is "pato puto", that my friend did, where the agent has a few tools that it can use to mess with the user screen, and the agent chooses freely: we want that dynamicity, full dynamic as a friend that wants to mess with you and has a few different commands to run.

## **🚫 When NOT to use agents**

- **Enterprise Automation:** Building stable, reliable software? Don’t use agents. You can’t have an LLM deciding critical workflows in production. Use orchestrator patterns instead.

- **High-Stakes Decisions:** Financial transactions, medical diagnoses, and legal compliance need deterministic logic, not LLM guesswork.

#### ✅ Build explicit handoff protocols via the workflows, rather than using free-form delegation.

[Anthropic workflows cookbook](https://github.com/anthropics/anthropic-cookbook/tree/main/patterns/agents)

But, one thing to try, agents with human in the loop scenarios, [[AI Agents frameworks - that help!#^9442ed]]
