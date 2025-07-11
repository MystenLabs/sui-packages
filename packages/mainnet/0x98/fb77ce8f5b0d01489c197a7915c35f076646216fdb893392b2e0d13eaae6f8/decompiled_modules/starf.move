module 0x98fb77ce8f5b0d01489c197a7915c35f076646216fdb893392b2e0d13eaae6f8::starf {
    struct STARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARF>(arg0, 6, b"STARF", b"Starfish", b"A starfish wandering in the sea, afraid of being eaten by big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicv353wjedy7mfa4fkdoxkpe2qry5v5hom73dkz55acyqzwu5ifva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STARF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

