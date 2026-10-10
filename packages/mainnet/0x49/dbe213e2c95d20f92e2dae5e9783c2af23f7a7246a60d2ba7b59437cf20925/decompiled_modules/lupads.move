module 0x49dbe213e2c95d20f92e2dae5e9783c2af23f7a7246a60d2ba7b59437cf20925::lupads {
    struct LUPADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUPADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUPADS>(arg0, 9, b"LUPADS", b"Lupads", b"LUPADS Early in. Stay loyal. Grow together. The next big thing starts with the community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0xc58982d1ddf1959d32aff72983c0fbb8c92c8bfdc5b43dd58b342df96d3ebb4a/7c1bcbb6-9266-4da4-82b1-8a96bd60bd0c.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUPADS>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUPADS>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

