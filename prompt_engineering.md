OpenAI's practical guide to building agentes https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf

Google's prompt engineering: https://www.gptaiflow.tech/assets/files/2025-01-18-pdf-1-TechAI-Goolge-whitepaper_Prompt%20Engineering_v4-af36dcc7a49bb7269a58b1c9b89a8ae1.pdf

## Notes from prompt engineering by google

> You don't need to be a data scientist or a machine leraning engineer - everyone can write a prompt.

Muito importante trazer isso pois muitas pessoas se limitam ou nem comecam a fazer as coisas achando que tem que ser alguem especifico do dominio para fazer isso etc.

**Temperature** - The higher, all tokens become equally likely to be the next predicted token.
**Top-K** - Top K most likely tokens from the predited distribution. More top-K, more creative and varied outputs, lower = more restive and factural.
**Top-P** - Selects the top tokens whose cumm prob does not exceed P, 0-greedy 1-all tokens in vocab

## Prompting Techniques

## Zero shot

- Simplest form of prompting.
- No examples.
- Simply a description of the task or question.

## One-shot & few-shot

- It's very helpful to provide examples.
- One-shot, as the name says, you provide a signle example.
- Few-shot, provides multiple examples to the model, showing a pattern that it needs to follow, the number of examples you need depends on the task at hand, complexity, quality of the examples, at least **3-5** examples for few-shot, could be more.
- Quality of the examples is very important.
- If you want a robust output, be sure to include edge cases in the examples.

## System, contextual and role prompting

**System prompting**: defines the big picture of what the model should be doing, like translating a language, classifying a review, being a query generator. - Set the fundamental capabilities

- Classify things as X Y Z
  **Contextual prompting**: provides specific details/background info relevant to the task. Helps the model understand what's being asked, and tailor the response accordingly. - Immediate info to guide the response, highly specific to the input
- Context: you are writing for a coding blog. Suggest...
  **Role prompting**: Assigns a specific character or identity for the model to adopt. Helps generate responses that are consistent with the role and its associated knowledge and behavior. - Style and Voice
- Some tones of voice that shape the output: Confrontational, Descriptive, Direct, Formal, Humorous, Influential, Informal, Inspirational, Persuasive
- You are a travel instructor, suggest me 3 places to visit in a humorous style.

> **JSON Format** forces the model to keep a structure, limits hallucinations, helps you to parse the results in code in a format you already expect.

## Step back prompting

- When you step back, ask another AI for some information that can help you shape a better and more accurate prompt.
- For example you get some basic context for the task and ask the AI to base the new response on that.

## Chain of thought (CoT)

- Improve reasoning capabilities by generating intermediate reasoning steps. Combine with few shot to get better results on more complex tasks that rquire reasoning before responding.
- Works well with off-the-shelf LLMs (No finetune!). You can get interpretability – see and learn from the reasoning steps that it followed – and if there's a malfunction you can identify it! CoT improves robustness when moving betwen LLM versions.
- Drawbacks are that there are more output tokens, so they take longer and cost more money.
- e.g. usage "Let's think step by step"
- Specially powerful if you can provide examples showing how **you** would do the step by step, basically guiding it to think like you.
- **If you can explain the steps, try CoT!**

## Self-consistency

-

# Resources etc

- [chat gpt write naturally prompt](https://x.com/markgadala/status/1930637344790421785?s=46)

From Yc
https://x.com/hesamation/status/1931085643494420822?s=46

Prompt lib:

For business;
https://x.com/ridbay/status/1931405358519435766?s=46

Growth consultant
https://x.com/ghumare64/status/1931277894980166004?s=46
