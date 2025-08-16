module 0xbd6e3c6f5ffb83b0b61b7ec5ebf109e46a6bd791ea7585017335afbd185da4c8::dra {
    struct DRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRA>(arg0, 6, b"DRA", b"Decentralized Retirement Account", b"Decentralized Retirement Account)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibe3jkzn3mgudhtsm6qnqut2qwyg2awnbg6n5bifxdi6lnmtrckji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

