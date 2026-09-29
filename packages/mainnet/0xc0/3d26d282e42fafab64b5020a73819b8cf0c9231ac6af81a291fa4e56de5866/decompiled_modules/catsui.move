module 0xc03d26d282e42fafab64b5020a73819b8cf0c9231ac6af81a291fa4e56de5866::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 9, b"CATSUI", b"CATSUI", b"CATSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/f5add4770f9fb4155142f03562774581bab049a90c371c24442824ebabbce846")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CATSUI>>(0x2::coin::mint<CATSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

