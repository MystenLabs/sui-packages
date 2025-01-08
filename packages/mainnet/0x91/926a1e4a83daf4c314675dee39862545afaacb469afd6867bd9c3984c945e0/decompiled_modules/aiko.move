module 0x91926a1e4a83daf4c314675dee39862545afaacb469afd6867bd9c3984c945e0::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"AIKO", b"Agent AiKo by SuiAI", b"Agent AiKo is a crypto market navigator.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1305_757e2eb163.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

