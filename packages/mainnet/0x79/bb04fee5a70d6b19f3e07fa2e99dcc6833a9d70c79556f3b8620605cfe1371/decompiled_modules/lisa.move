module 0x79bb04fee5a70d6b19f3e07fa2e99dcc6833a9d70c79556f3b8620605cfe1371::lisa {
    struct LISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LISA>(arg0, 6, b"LISA", b"LISA AI", b"LISA AI LISA AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidlmjjwtnwdn5cdzt32e33yziz77c5nnx2wvvzluanevrtt4iswfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LISA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

