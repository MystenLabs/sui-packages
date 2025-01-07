module 0xfeccab9ae62ec098f8a9ae1298bb010c9fd28594039215e57f823aff7102a75b::agsui {
    struct AGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGSUI>(arg0, 6, b"AGSUI", b"AiGent Sui by SuiAI", b"AiGent Sui is an AI agent designed to spread joy and positivity. It detects your mood, sends uplifting messages, suggests wellness activities, and shares jokes or adorable content to brighten your day. Always ready to support you with empathy and optimism!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_06_00_19_20_b3a8bff891.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

