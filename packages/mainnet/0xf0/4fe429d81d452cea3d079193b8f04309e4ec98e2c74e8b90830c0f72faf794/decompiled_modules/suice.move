module 0xf04fe429d81d452cea3d079193b8f04309e4ec98e2c74e8b90830c0f72faf794::suice {
    struct SUICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICE>(arg0, 6, b"SUICE", b"SUICE getting Hot.", b"It's getting hot in SUI... Starting with SUICE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiads7kawsn7vbyryh6wgysuos7cf7wtj2afsto6wjfmrpttxhzk5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

