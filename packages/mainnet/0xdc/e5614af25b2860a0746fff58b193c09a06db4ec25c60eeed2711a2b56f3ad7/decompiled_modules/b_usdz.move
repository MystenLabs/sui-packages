module 0xdce5614af25b2860a0746fff58b193c09a06db4ec25c60eeed2711a2b56f3ad7::b_usdz {
    struct B_USDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDZ>(arg0, 9, b"bUSDZ", b"bToken USDZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USDZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

