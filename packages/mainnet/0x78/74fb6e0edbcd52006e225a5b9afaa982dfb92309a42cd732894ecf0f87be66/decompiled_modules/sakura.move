module 0x7874fb6e0edbcd52006e225a5b9afaa982dfb92309a42cd732894ecf0f87be66::sakura {
    struct SAKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAKURA>(arg0, 6, b"SAKURA", b"Sakura AI by SuiAI", b"A beatifull AI on SUIAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ayme_6801311843.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAKURA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKURA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

