module 0xc3256fa95d2fdd9f7b91364d435dcc4ce655a2e733a126b6d477d06742586d37::catzo {
    struct CATZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZO>(arg0, 6, b"CATZO", b"Sui Catzo", b"Catzo Its a new strong Memecoin with the power of the Cat is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibneekcdw24elubz53fwiynjbsmqdxyvhlibg32wvw5mdqwmn6lfu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

