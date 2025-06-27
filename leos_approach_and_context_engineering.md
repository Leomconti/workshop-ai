> Most "AI Agents" today are complex state machines orchestrating LLM API calls, not true autonomous agents adapting their "process".

Also take a look here: https://www.deeplearning.ai/the-batch/how-agents-can-improve-llm-performance/

I really liked the concepts in [[Twelve 12 factor  agents]], I find that it resonates to my ideas, and they wrote it down in a more structured manner.

My issue with n8n: I simply never got into it. I feel way more comfortable coding, integrating things and keeping state through code, and not dependent on plugins or other things. For me, iterating in code is way faster and I can control every single step.

# Everyone talks about tool calling: **tool calling is just structured output**

You do not need said tools tool calling agent loop, well, you can have if you'd like, but... AI Agents are simply LLM calls with structured outputs that can you do something with. They don't need to be complex, again, they are just structured output!

# Everything is context engineering

### LLMs are stateless functions that turn inputs into outputs. To get the best outputs, you need to give them the best inputs!

- The prompt and instructions you give to the model
- Any documents or external data you retrieve (e.g. RAG)
- Any past state, tool calls, results, or other history
- Any past messages or events from related but separate histories/conversations (Memory)
- Instructions about what sorts of structured data to output

You want the flexibility to try everything and add everything to context as you want.

You can use the standard user/assistant/tool messaging format from OpenAI, yes! Example:

```json
[
  {
    "role": "system",
    "content": "You are a helpful assistant..."
  },
  {
    "role": "user",
    "content": "Can you deploy the backend?"
  },
  {
    "role": "assistant",
    "content": null,
    "tool_calls": [
      {
        "id": "1",
        "name": "list_git_tags",
        "arguments": "{}"
      }
    ]
  },
  {
    "role": "tool",
    "name": "list_git_tags",
    "content": "{\"tags\": [{\"name\": \"v1.2.3\", \"commit\": \"abc123\", \"date\": \"2024-03-15T10:00:00Z\"}, {\"name\": \"v1.2.2\", \"commit\": \"def456\", \"date\": \"2024-03-14T15:30:00Z\"}, {\"name\": \"v1.2.1\", \"commit\": \"abe033d\", \"date\": \"2024-03-13T09:15:00Z\"}]}",
    "tool_call_id": "1"
  }
]
```

While this works great for most use cases, if you want to really get THE MOST out of today's LLMs, you need to get your context into the LLM in the most token- and attention-efficient way you can.

As they are stateless, and don't remember what you did on the previous iteration, you can take the lead and modify the context so that it can make a better next response
For example using:

```json
[
  {
    "role": "system",
    "content": "You are a helpful assistant..."
  },
  {
    "role": "user",
    "content": |
            Here's everything that happened so far:

        <slack_message>
            From: @alex
            Channel: #deployments
            Text: Can you deploy the backend?
        </slack_message>

        <list_git_tags>
            intent: "list_git_tags"
        </list_git_tags>

        <list_git_tags_result>
            tags:
              - name: "v1.2.3"
                commit: "abc123"
                date: "2024-03-15T10:00:00Z"
              - name: "v1.2.2"
                commit: "def456"
                date: "2024-03-14T15:30:00Z"
              - name: "v1.2.1"
                commit: "ghi789"
                date: "2024-03-13T09:15:00Z"
        </list_git_tags_result>

        what's the next step?
    }
]
```

The model may infer that you're asking it `what's the next step` by the tool schemas you supply, but it never hurts to roll it into your prompt template.
Basically, you are updating your context to give the most accurate instruction to the LLM.

From here your next step might be:

```python
nextStep = await determine_next_step(thread_to_prompt(thread))
```

{
"intent": "get_workflow_status",
"workflow_name": "tag_push_prod.yaml",
}

Basically, you don't need to be hostage of fully automated agentic loops with tool calls, with one fixed prompt. You can mold whatever you want! You can have a ton of prompts, different ways to format and use it, and do the handling in code as you wish, based on the previous input.

Still on context engineering:

> **The Importance of "Context Engineering"**: **LangChain's** [@hwchase17](https://41598e5c38d3cd55e335e985614d0883.us-east-1.resend-links.com/CL0/https:%2F%2Ftwitter.com%2Fhwchase17%2Fstatus%2F1933278290992845201/1/0100019767c30414-a094d8de-e63f-4cec-804d-f5a8df7c7ead-000000/mF_umsNJUqJGuO6egQQ1yk8fv7cYM5aDrMSPJdxDxy4=409) highlights the concept of **"Context Engineering"** as the next level of prompt engineering. He defines it as the process of dynamically and automatically providing a system with the necessary context, calling it the "**#1 job of engineers building AI agents**."

# The best AI agents are built without frameworks!

[Ai engineer talk on primitives over frameworks for ai agents](https://www.youtube.com/watch?v=fcPUqxfrE6Y)

Theya re built on primitives!! Not frameworks

Don't use langchain levelsio https://x.com/levelsio/status/1804078191385956668
