module 0xa931d3161c8bb4e2fee6fe71478e944c6d8c61a37d0d15a93d54345c8cafd004::htbt {
    struct HTBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTBT>(arg0, 9, b"HTBT", b"HTBT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HTBT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

