from typing import TypedDict
from langgraph.graph import StateGraph, START, END

from app.resilience_service import get_resilience_summary
from app.resilience_agent import evaluate_resilience


class ResilienceState(TypedDict):
    summary: dict
    decision: dict
    safety: dict
    approval: dict
    approved: bool
    action: dict


def load_summary(state: ResilienceState):
    return {
        "summary": get_resilience_summary()
    }


def evaluate_decision(state: ResilienceState):
    return {
        "decision": evaluate_resilience()
    }


def safety_gate(state: ResilienceState):
    decision = state["decision"]["decision"]

    if decision == "REVIEW_REQUIRED":
        return {
            "safety": {
                "status": "HUMAN_APPROVAL_REQUIRED",
                "message": "Human approval is required before any resilience experiment action."
            }
        }

    return {
        "safety": {
            "status": "BLOCKED",
            "message": "Experiment action is blocked because the decision is not approved."
        }
    }


def human_approval(state: ResilienceState):
    if state.get("approved", False):
        return {
            "approval": {
                "status": "APPROVED",
                "message": "Human approval received. Proceeding to the safe action stage."
            }
        }

    return {
        "approval": {
            "status": "PENDING",
            "message": "Waiting for explicit human approval."
        }
    }


def route_after_approval(state: ResilienceState):
    if state["approval"]["status"] == "APPROVED":
        return "safe_action"

    return END


def safe_action(state: ResilienceState):
    return {
        "action": {
            "status": "SIMULATION_ONLY",
            "message": "Approved action reached. No Azure resource or VM was modified."
        }
    }


builder = StateGraph(ResilienceState)

builder.add_node("load_summary", load_summary)
builder.add_node("evaluate_decision", evaluate_decision)
builder.add_node("safety_gate", safety_gate)
builder.add_node("human_approval", human_approval)
builder.add_node("safe_action", safe_action)

builder.add_edge(START, "load_summary")
builder.add_edge("load_summary", "evaluate_decision")
builder.add_edge("evaluate_decision", "safety_gate")
builder.add_edge("safety_gate", "human_approval")

builder.add_conditional_edges(
    "human_approval",
    route_after_approval,
    {
        "safe_action": "safe_action",
        END: END
    }
)

builder.add_edge("safe_action", END)

graph = builder.compile()


if __name__ == "__main__":
    result = graph.invoke({
        "approved": False
    })

    print("LANGGRAPH RESILIENCE WORKFLOW")
    print("-----------------------------")
    print("Decision:", result["decision"]["decision"])
    print("Safety:", result["safety"]["status"])
    print("Approval:", result["approval"]["status"])

    if "action" in result:
        print("Action:", result["action"]["status"])
        print("Action Message:", result["action"]["message"])
    else:
        print("Action: NOT EXECUTED")
