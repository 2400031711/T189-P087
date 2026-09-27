from app.resilience_service import get_resilience_summary


def evaluate_resilience():
    summary = get_resilience_summary()

    experiment = summary["experiment"]
    metrics = experiment["metrics"]

    if (
        metrics["FailoverOccurred"] is True
        and metrics["RecoveryOccurred"] is True
        and metrics["FailoverSuccessRate"] == 100
        and metrics["RecoverySuccessRate"] == 100
    ):
        decision = "REVIEW_REQUIRED"
        reason = (
            "Failover and recovery were observed successfully, "
            "but only one experiment instance is available."
        )
    else:
        decision = "REVIEW_REQUIRED"
        reason = "Resilience evidence is incomplete or indicates a failure."

    return {
        "decision": decision,
        "reason": reason,
        "experiment": experiment["experiment"]
    }


if __name__ == "__main__":
    result = evaluate_resilience()

    print("RESILIENCE AGENT DECISION")
    print("--------------------------")
    print("Decision:", result["decision"])
    print("Reason:", result["reason"])
    print("Experiment:", result["experiment"])
