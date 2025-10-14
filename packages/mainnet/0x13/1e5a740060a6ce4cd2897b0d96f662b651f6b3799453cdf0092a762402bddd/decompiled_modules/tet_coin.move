module 0x131e5a740060a6ce4cd2897b0d96f662b651f6b3799453cdf0092a762402bddd::tet_coin {
    struct TET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET_COIN>(arg0, 9, b"TET", b"test", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

