module 0x5a5228427102ac65269d75ee7c679f5b4d379fc4862da1b5af3501a3bf96338c::optr {
    struct OPTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTR>(arg0, 6, b"OPTR", b"Op Trade Ai", b"Our advanced AI systems continuously monitor blockchain transactions, market movements, and trading patterns across multiple networks to gather realtime intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyf5ccutreyezdbnrbybxe2h256c7zsbaxicobi5wnil2wkqtpzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OPTR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

