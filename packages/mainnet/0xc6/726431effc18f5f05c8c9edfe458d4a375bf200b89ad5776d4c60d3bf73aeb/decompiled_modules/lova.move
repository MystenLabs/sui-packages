module 0xc6726431effc18f5f05c8c9edfe458d4a375bf200b89ad5776d4c60d3bf73aeb::lova {
    struct LOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVA>(arg0, 6, b"LOVA", b"LOVA YA BIG", b"LOVA YA BIG BRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreierq5vl25e4nl6s2ie2s4hsksfdjfkjertdoue4lrt22ismmox5sy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOVA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

