module 0x89b3fcc2132b689aa123fe3685aaba0a949884807a1dfcdaf589a8fd090273a1::gbs {
    struct GBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBS>(arg0, 6, b"GBS", b"GoldmanBallsachs", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GBS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

