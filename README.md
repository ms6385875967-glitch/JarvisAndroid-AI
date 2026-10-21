# Jarvis for Android

Voice-controlled phone assistant. Say **"Jarvis ..."** in Tamil / Tanglish / English; Claude decides what to do and the app opens apps, calls, messages, sets alarms, taps and scrolls.

## Setup (Android Studio)

1. Open this folder in **Android Studio** (Koala or newer). Let Gradle sync.
2. Copy `local.properties.example` lines into `local.properties` and set your key:
   `ANTHROPIC_API_KEY=sk-ant-...`
3. Run on a real phone (Android 8+). The emulator mic is unreliable.
4. In the app tap the buttons in order:
   1. Grant permissions
   2. Enable accessibility → Settings > Accessibility > **Jarvis** > On
   3. Disable battery optimisation (so Android doesn't kill the service)
   4. **START Jarvis**
5. Say "Jarvis" ... beep ... "WhatsApp open pannu", or in one go: "Jarvis, naalaikku 6 mani ku alarm vei".

## Structure

| File | Job |
|---|---|
| `JarvisService.kt` | Foreground service: listen, wake word, TTS, orchestration |
| `ClaudeClient.kt` | Calls Claude API, returns `{speech, actions[]}` JSON |
| `ActionExecutor.kt` | Runs actions: intents (call/SMS/alarm/apps) and accessibility actions |
| `JarvisAccessibilityService.kt` | Back/home/recents, tap by text, scroll, type, screenshot |
| `MainActivity.kt` | Setup screen |

## Known limits

- Wake word uses Google SpeechRecognizer text matching. It works but uses battery and has a small beep/restart gap. Upgrade path: Picovoice Porcupine.
- The API key is compiled into the app. Fine for personal use. Do not publish this APK; for sharing, route calls through your own backend.
- Banking/payment apps block accessibility control, and the system prompt tells Claude to refuse money actions.
- Call/SMS need the permissions granted. WhatsApp opens the chat with the message prefilled; you press send (or ask Jarvis "tap Send").
- Speech language is `en-IN`, which handles Tanglish reasonably. Pure Tamil: change `"en-IN"` to `"ta-IN"` in `JarvisService.kt`.
