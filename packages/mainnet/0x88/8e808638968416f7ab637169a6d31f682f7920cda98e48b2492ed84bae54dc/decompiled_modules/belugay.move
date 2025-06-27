module 0x888e808638968416f7ab637169a6d31f682f7920cda98e48b2492ed84bae54dc::belugay {
    struct BELUGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGAY>(arg0, 6, b"BELUGAY", b"BELUGAY SUI", b"I'am BeluGay, U gay???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifezvs5hvmcq7fyuwzwhob7tggnniejnywrnqxp4dxer7uiv4urtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BELUGAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

