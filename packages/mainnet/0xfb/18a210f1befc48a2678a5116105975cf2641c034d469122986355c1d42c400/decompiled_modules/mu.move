module 0xfb18a210f1befc48a2678a5116105975cf2641c034d469122986355c1d42c400::mu {
    struct MU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MU>(arg0, 9, b"MU", b"Micron Technology", b"ZO Virtual Coin for Micron Technology", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MU>>(v0);
    }

    // decompiled from Move bytecode v6
}

