import json
import re
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
PACKAGE = ROOT / "package"


def fail(message: str) -> None:
    raise SystemExit(message)


def validate_manifest() -> None:
    manifest_path = PACKAGE / "pet.json"
    if not manifest_path.exists():
        fail("package/pet.json is missing")

    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    expected = {
        "id": "pink-signal",
        "displayName": "Pink Signal",
        "spritesheetPath": "spritesheet.webp",
    }
    for key, value in expected.items():
        if manifest.get(key) != value:
            fail(f"pet.json {key!r} must be {value!r}")

    description = manifest.get("description", "")
    if not isinstance(description, str) or not description.strip():
        fail("pet.json description must be a non-empty string")


def validate_spritesheet() -> None:
    spritesheet = PACKAGE / "spritesheet.webp"
    if not spritesheet.exists():
        fail("package/spritesheet.webp is missing")

    with Image.open(spritesheet) as image:
        if image.format != "WEBP":
            fail(f"spritesheet format must be WEBP, got {image.format}")
        if image.mode != "RGBA":
            fail(f"spritesheet mode must be RGBA, got {image.mode}")
        if image.size != (1536, 1872):
            fail(f"spritesheet size must be 1536x1872, got {image.size}")


def validate_public_text() -> None:
    path_patterns = [
        "C:" + r"\\Users\\",
        "Phoenix" + "EYE",
        "a" + "8720",
        "wang" + "87200543",
        "imagegen" + "-jobs",
        "pet" + "_request",
        "generated" + "_images",
        "ghp" + "_",
        "github" + "_pat_",
    ]
    auth_patterns = [
        "sk" + r"-[A-Za-z0-9]{20,}",
        "api" + r"[_-]?key",
        "bear" + "er",
        "author" + "ization",
    ]
    forbidden = re.compile(
        "(" + "|".join(path_patterns + auth_patterns) + ")",
        re.IGNORECASE,
    )

    for path in ROOT.rglob("*"):
        if path.is_dir() or ".git" in path.parts:
            continue
        if path.suffix.lower() in {".webp", ".png", ".jpg", ".jpeg", ".mp4"}:
            continue
        text = path.read_text(encoding="utf-8", errors="ignore")
        match = forbidden.search(text)
        if match:
            fail(f"forbidden public text matched {match.group(0)!r} in {path.relative_to(ROOT)}")


def main() -> None:
    validate_manifest()
    validate_spritesheet()
    validate_public_text()
    print("Package validation passed.")


if __name__ == "__main__":
    main()
