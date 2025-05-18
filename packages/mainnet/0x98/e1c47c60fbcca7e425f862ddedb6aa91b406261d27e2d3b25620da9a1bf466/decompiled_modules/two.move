module 0x98e1c47c60fbcca7e425f862ddedb6aa91b406261d27e2d3b25620da9a1bf466::two {
    struct TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO>(arg0, 6, b"TWO", b"Mewtwo", b"Born from the DNA of ONE, but evolved with attitude - stronger, sharper, and ready to dominate the chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccwl5mp2tb7ef7zy4xapuwl2coatjjk63myizxh2rlcmi2ojly4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

