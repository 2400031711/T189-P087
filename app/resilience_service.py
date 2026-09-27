import json

REPORT_PATH = "/home/veeramreddy/T189-P087/resilience-report.json"
ANALYSIS_PATH = "/home/veeramreddy/T189-P087/resilience-analysis.json"


def get_experiment_report():
    with open(REPORT_PATH, "r") as f:
        return json.load(f)


def get_ai_analysis():
    with open(ANALYSIS_PATH, "r") as f:
        return json.load(f)


def get_resilience_summary():
    return {
        "experiment": get_experiment_report(),
        "ai_analysis": get_ai_analysis()
    }
