module 0xb849588dbabf262571cb11e2eaeec2111dca34ed4ebc2cfcbf517e4fbbde542c::genos {
    struct GENOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENOS>(arg0, 6, b"GENOS", b"GENOS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

