module 0x491529978648f6506c21045f70bfad2830a6da83723e120ed6fff889ee747b99::tradegpt {
    struct TRADEGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADEGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRADEGPT>(arg0, 6, b"TRADEGPT", b"Trade GPT by SuiAI", b"Gpt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_16_80e9ecee48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRADEGPT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADEGPT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

