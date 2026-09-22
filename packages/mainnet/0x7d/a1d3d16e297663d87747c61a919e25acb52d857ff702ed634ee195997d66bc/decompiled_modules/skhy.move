module 0x7da1d3d16e297663d87747c61a919e25acb52d857ff702ed634ee195997d66bc::skhy {
    struct SKHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKHY>(arg0, 6, b"SKHY", b"SK Hynix", b"ZO Virtual Coin for SK Hynix (SKHYNIX)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKHY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SKHY>>(v0);
    }

    // decompiled from Move bytecode v7
}

