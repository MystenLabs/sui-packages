module 0xa12776eddfae88e487465b8835d8364e7ca8ed0e440fc472a2dd2865c4be9be9::suixseven {
    struct SUIXSEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXSEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXSEVEN>(arg0, 6, b"SUIXSEVEN", b"SUIXSEVEN", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXSEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIXSEVEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

