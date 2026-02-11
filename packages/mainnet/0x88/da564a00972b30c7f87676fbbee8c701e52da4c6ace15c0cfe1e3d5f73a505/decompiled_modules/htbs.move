module 0x88da564a00972b30c7f87676fbbee8c701e52da4c6ace15c0cfe1e3d5f73a505::htbs {
    struct HTBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTBS>(arg0, 7, b"HTBS", b"HeartbeatStellar", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HTBS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

