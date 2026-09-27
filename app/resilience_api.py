from pathlib import Path
from fastapi import FastAPI
from fastapi.responses import FileResponse

from app.resilience_service import (
    get_experiment_report,
    get_ai_analysis,
    get_resilience_summary
)
from app.resilience_graph import graph

app = FastAPI(
    title="Resilience Command Center API",
    description="API for the Azure resilience experiment",
    version="1.0.0"
)

@app.get("/")
def root():
    return {
        "status": "online",
        "service": "Resilience Command Center API"
    }

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.get("/experiment")
def experiment():
    return get_experiment_report()

@app.get("/analysis")
def analysis():
    return get_ai_analysis()

@app.get("/summary")
def summary():
    return get_resilience_summary()

@app.get("/decision")
def decision():
    return graph.invoke({"approved": False})

@app.get("/decision/approve")
def approve_decision():
    return graph.invoke({"approved": True})

@app.get("/dashboard")
def dashboard():
    return FileResponse(
        Path(__file__).parent / "dashboard.html"
    )
