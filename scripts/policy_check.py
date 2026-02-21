import os
import sys

ALLOWED_ENVS = {"dev", "staging", "prod"}

def fail(msg: str, code: int = 1) -> None:
    print(f"ERROR: {msg}")
    sys.exit(code)

env = os.getenv("ENVIRONMENT", "dev").strip().lower()
replica_raw = os.getenv("REPLICA_COUNT", "").strip()

if env not in ALLOWED_ENVS:
    fail(f"ENVIRONMENT must be one of {sorted(ALLOWED_ENVS)}, got: {env!r}")

# Non-prod: allow defaulting if REPLICA_COUNT not provided
if env in {"dev", "staging"} and replica_raw == "":
    replica_count = 1
    print(f"OK: ENVIRONMENT={env}, REPLICA_COUNT={replica_count} (defaulted)")
    sys.exit(0)

# Prod (and any explicit override): must be provided and valid int
if replica_raw == "":
    fail("REPLICA_COUNT is required")

try:
    replica_count = int(replica_raw)
except ValueError:
    fail(f"REPLICA_COUNT must be an integer, got: {replica_raw!r}")

if replica_count < 1:
    fail("REPLICA_COUNT must be >= 1")

if env == "prod" and replica_count < 3:
    fail("prod requires REPLICA_COUNT >= 3")

print(f"OK: ENVIRONMENT={env}, REPLICA_COUNT={replica_count}")
sys.exit(0)