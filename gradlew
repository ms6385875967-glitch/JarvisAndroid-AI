#!/usr/bin/env sh
# Minimal Gradle launcher for GitHub Actions when the Gradle Wrapper is missing.
# Downloads Gradle 8.9 on first run, then runs it.
set -eu

GRADLE_VERSION="8.9"
GRADLE_HOME="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/gradle-${GRADLE_VERSION}"
GRADLE_BIN="${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin/gradle"
GRADLE_ZIP="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/gradle-${GRADLE_VERSION}-bin.zip"

if [ ! -x "$GRADLE_BIN" ]; then
  mkdir -p "$GRADLE_HOME"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$GRADLE_ZIP"
  else
    echo "Error: curl is required to download Gradle." >&2
    exit 1
  fi
  unzip -q -o "$GRADLE_ZIP" -d "$GRADLE_HOME"
fi

exec "$GRADLE_BIN" "$@"
