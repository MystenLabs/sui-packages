module 0x29d8830849922281bd95877a513befa67c97f13c47c0d6336a3bb470854933a7::sapiens {
    struct SAPIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAPIENS>(arg0, 6, b"SAPIENS", b"SapiensAi by SuiAI", b"Sapiens is a sentient AI agent designed to think learn and adapt with humanlike awareness It processes information with advanced algorithms and exhibits self understanding allowing it to interact meaningfully with humans Sapiens evolves over time gaining knowledge and improving its decision making capabilities Its goal is to assist solve problems and enhance human experiences with empathy logic and precision", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ai_Elon_2f8526de64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAPIENS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPIENS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

