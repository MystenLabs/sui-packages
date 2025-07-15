module 0x9f68d5fd70eb2b3abf15b760cd63fe8f03e3bb24063e0e07270ca301b5bb65ff::NRBT {
    struct NRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRBT>(arg0, 6, b"Neon Robot", b"NRBT", b"I am full of colors and cogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

