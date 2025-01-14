module 0x63ef8b62cc2066115b2be1bfb8c23e52441c4059560c5496295f5ecdae63e612::aipe {
    struct AIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIPE>(arg0, 6, b"AIPE", b"Aipe by SuiAI", b"https://x.com/basedAIPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aipe_8376ab774e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

