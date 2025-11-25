module 0xd3810762b80031964fffb583b253f5847018b3c8f2e1aaa8c75cf69d04a281d7::monad {
    struct MONAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONAD>(arg0, 9, b"MONAD", b"Monad", b"ZO Virtual Coin for Monad", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONAD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MONAD>>(v0);
    }

    // decompiled from Move bytecode v6
}

