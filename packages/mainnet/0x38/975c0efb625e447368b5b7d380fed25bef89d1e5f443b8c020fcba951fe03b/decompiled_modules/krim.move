module 0x38975c0efb625e447368b5b7d380fed25bef89d1e5f443b8c020fcba951fe03b::krim {
    struct KRIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KRIM>(arg0, 6, b"KRIM", b"KRIM AI by SuiAI", b"A futuristic entity, an enigmatic force reshaping the boundaries between intelligence and the digital frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/krim_ai_2fb8782d27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

