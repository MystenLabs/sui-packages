module 0xdcbd1f705333f86aba52368e5b8c0e9bb67a24bd3624cf6be48ed88c27cbbedb::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Wrapped Cardano", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ADA>>(v0);
    }

    // decompiled from Move bytecode v6
}

