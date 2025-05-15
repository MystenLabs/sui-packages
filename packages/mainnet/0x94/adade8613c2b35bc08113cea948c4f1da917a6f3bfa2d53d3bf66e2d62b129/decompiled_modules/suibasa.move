module 0x94adade8613c2b35bc08113cea948c4f1da917a6f3bfa2d53d3bf66e2d62b129::suibasa {
    struct SUIBASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASA>(arg0, 6, b"SUIBASA", b"SUIBASAUR", x"506f6b656d6f6e20636f696e7320617265207469636b6572732e0a53554942415341206973205449434b45522e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiefd7qzndfcp6gawgvd4tebhmwgszfoedcey7qtlkcszdiwd52eza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBASA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

