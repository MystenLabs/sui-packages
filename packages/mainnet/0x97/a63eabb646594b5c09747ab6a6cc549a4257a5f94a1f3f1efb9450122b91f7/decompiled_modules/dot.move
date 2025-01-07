module 0x97a63eabb646594b5c09747ab6a6cc549a4257a5f94a1f3f1efb9450122b91f7::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 10, b"DOT", b"Wrapped Polkadot", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOT>>(v0);
    }

    // decompiled from Move bytecode v6
}

