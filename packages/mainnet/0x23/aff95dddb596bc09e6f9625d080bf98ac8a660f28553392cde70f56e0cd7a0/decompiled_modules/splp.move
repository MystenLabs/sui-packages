module 0x23aff95dddb596bc09e6f9625d080bf98ac8a660f28553392cde70f56e0cd7a0::splp {
    struct SPLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLP>(arg0, 9, b"SPLP", b"Scallop Perps LP", b"Liquidity provider token of the Scallop perpetuals pool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

