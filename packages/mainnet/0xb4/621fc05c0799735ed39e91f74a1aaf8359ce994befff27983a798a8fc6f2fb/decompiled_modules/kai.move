module 0xb4621fc05c0799735ed39e91f74a1aaf8359ce994befff27983a798a8fc6f2fb::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"Kai by SuiAI", b".PIKAI: The Ultimate Evolution.PIKAI is an AI Agent that grows with its market cap. Emerging from its", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000014966_9eddd64a75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

