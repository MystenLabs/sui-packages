module 0xffbe3b8f0fa46c54f3e6446ebc644136949beb6c7db45b9153e7cf7d53c9a7f9::dot {
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

