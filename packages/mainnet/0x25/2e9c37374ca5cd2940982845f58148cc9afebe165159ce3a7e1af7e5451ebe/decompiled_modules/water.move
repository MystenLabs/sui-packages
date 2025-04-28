module 0x252e9c37374ca5cd2940982845f58148cc9afebe165159ce3a7e1af7e5451ebe::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"ALL LIFE IS WATER", b"WATER IS VERY IMPORTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/B6h248NJkAcBAkaCnji889a26tCiGXGN8cxhEJ4dX391.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WATER>>(0x2::coin::mint<WATER>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WATER>>(v2);
    }

    // decompiled from Move bytecode v6
}

