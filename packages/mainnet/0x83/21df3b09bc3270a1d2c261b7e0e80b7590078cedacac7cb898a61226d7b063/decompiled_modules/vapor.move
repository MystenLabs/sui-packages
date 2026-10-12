module 0x8321df3b09bc3270a1d2c261b7e0e80b7590078cedacac7cb898a61226d7b063::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOR>(arg0, 9, b"VAPOR", b"Vaporware", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/ddfccdbb6a10411df4bcc2daf350cc62ca61915af2e24b513daa40cd70e1a9b8")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(0x2::coin::mint<VAPOR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAPOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOR>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

