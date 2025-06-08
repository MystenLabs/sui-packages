module 0x1d68971023bda9b0ac543ea7dd9e9235e2b8a4a94a6f95d275986d808c4e31de::pokego {
    struct POKEGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEGO>(arg0, 6, b"POKEGO", b"POKEMON GO", b"pokemon go is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicjkoml5t5yfkeykhbk43725cb7dsi2woayhohvf3jrzjd4hlj4pu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

