module 0xb656067a0e110d9b8135f9864a498a01d994d257458bf412ae48ab1f5f6e5bfe::tokena {
    struct TOKENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENA>(arg0, 6, b"TOKENA", b"SUAI TOKENA by SuiAI", b"TOKENA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Untitled_82efafb783.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

