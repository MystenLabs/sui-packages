module 0x3880c88d59a937170c0b26b223e9464ee35e9a68047ff44b8d6360a9aa2931ad::donald_trump_1768931335062_yes {
    struct DONALD_TRUMP_1768931335062_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD_TRUMP_1768931335062_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD_TRUMP_1768931335062_YES>(arg0, 0, b"DONALD_TRUMP_1768931335062_YES", b"DONALD_TRUMP_1768931335062 YES", b"DONALD_TRUMP_1768931335062 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD_TRUMP_1768931335062_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD_TRUMP_1768931335062_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

