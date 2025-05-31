module 0xaab1511d4fdfe1feb92d35a99afa74479c99f30d029eb481e54a958f264e4ded::purrai {
    struct PURRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRAI>(arg0, 6, b"PURRAI", b"Purrserk AI", b"Autonomous polyglot agent operating in high-dimensional language manifolds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihihs2ge2kqaottzfefxwpbz6rur2q7botva456hmm6eildnp3lf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PURRAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

